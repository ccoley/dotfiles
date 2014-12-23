<?php
require_once 'libs/PhotoRings_DB.php';

class Ring {
	// Object properties
	private $id;
	private $ownerId;
	private $name;
	private $spanning;
	private $memberIds       = array();
	private $imageIds        = array();
	private $modifiedRing    = false;
	private $modifiedMembers = false;
	private $modifiedImages  = false;


	public function getId() {
		return $this->id;
	}

	public function getOwnerId() {
		return $this->ownerId;
	}

	public function getName() {
		return $this->name;
	}

	public function setName($name) {
		$this->name = $name;
		$this->modifiedRing = true;
	}

	public function getMemberIds() {
		return $this->memberIds;
	}

	public function getImageIds() {
		return $this->imageIds;
	}

	public function getMemberCount() {
		return count($this->memberIds);
	}

	public function getImageCount() {
		return count($this->imageIds);
	}

	public function addMember($memberId) {
		if (!in_array($memberId, $this->memberIds)) {
			$this->memberIds[] = $memberId;
			$this->modifiedMembers = true;
		}
	}

	public function removeMember($memberId) {
		$index = array_search($memberId, $this->memberIds);
		if ($index !== false) { // $index could be 0, so you have to explicitly check for boolean false
			unset($this->memberIds[$index]);
			$this->memberIds = array_values($this->memberIds);	// re-index the array
			$this->modifiedMembers = true;
		}
	}

	public function addImage($imageId) {
		if (!in_array($imageId, $this->imageIds)) {
			$this->imageIds[] = $imageId;
			$this->modifiedImages = true;
		}
	}

	public function removeImage($imageId) {
		$index = array_search($imageId, $this->imageIds);
		if ($index !== false) { // $index could be 0, so you have to explicitly check for boolean false
			unset($this->imageIds[$index]);
			$this->imageIds = array_values($this->imageIds);	// re-index the array
			$this->modifiedImages = true;
		}
	}

	public function isSpanning() {
		return ($this->spanning != 0);
	}

	public function buildFromId($id) {
		$db = new PhotoRings_DB();
		$query = $db->prepare("SELECT * FROM rings WHERE id=?");
		$query->execute(array($id));
		$results = $query->fetchAll(PDO::FETCH_ASSOC);

		if (!$results || empty($results)) {
			return false;
		}

		$this->id		= $results[0]['id'];
		$this->ownerId	= $results[0]['owner_id'];
		$this->name		= $results[0]['name'];
		$this->spanning = $results[0]['spanning'];

		// Populate the memberIds array
		$query = $db->prepare("SELECT user_id FROM ring_members WHERE ring_id=?");
		$query->execute(array($this->id));
		$this->memberIds = $query->fetchAll(PDO::FETCH_COLUMN, 0);

		// Populate the imageIds array
		$query = $db->prepare("SELECT image_id FROM ring_images WHERE ring_id=?");
		$query->execute(array($this->id));
		$this->imageIds = $query->fetchAll(PDO::FETCH_COLUMN, 0);

		return true;
	}

	public function save() {
		$db = new PhotoRings_DB();
		$db->beginTransaction();

		// Save changes to the ring itself
		// TODO: If ring is spanning, don't allow changes to the name
		if ($this->modifiedRing) {
			$query = $db->prepare("UPDATE rings SET name=? WHERE id=?");
			if (!$query->execute(array($this->name, $this->id))) {
				$db->rollBack();
				return false;
			}
		}

		// Save changes to the ring members
		if ($this->modifiedMembers) {
			$localMembers = $this->memberIds;

			$query = $db->prepare("SELECT user_id FROM ring_members WHERE ring_id=?");
			$query->execute(array($this->id));
			$dbMembers = $query->fetchAll(PDO::FETCH_COLUMN, 0);

			// If a member exists in both arrays, we don't need to add or remove it, so unset it in both arrays
			foreach ($dbMembers as $index1 => $member) {
				$index2 = array_search($member, $localMembers);
				if ($index2 !== false) {
					unset($dbMembers[$index1], $localMembers[$index2]);
				}
			}

			// IDs left in $dbMembers are members who need to be deleted from the DB
			// TODO: If ring is spanning, also remove members from all the user's other rings
			if (count($dbMembers) > 0) {
				$placeHolder = implode(',', array_fill(0, count($dbMembers), '?'));
				$query = $db->prepare("DELETE FROM ring_members WHERE ring_id=? AND user_id IN ($placeHolder)");
				$qString = $query->queryString;
				if (!$query->execute(array_merge(array($this->id), $dbMembers))) {
					$db->rollBack();
//					  return false;
					return array(false, $qString, implode(',', $dbMembers));
				}
			}

			// IDs left in $localMembers are members who need to be added to the DB
			// TODO: If ring is not spanning, also add new members to the user's spanning ring
			if (count($localMembers) > 0) {
				$placeHolder = implode(',', array_fill(0, count($localMembers), "(?,?)"));
				$query = $db->prepare("INSERT INTO ring_members (ring_id, user_id) VALUES " . $placeHolder);
				$qString = $query->queryString;

				// Build a new array with the ring ID as every other value
				$execArray = array();
				foreach($localMembers as $member) {
					$execArray[] = $this->id;
					$execArray[] = $member;
				}

				if (!$query->execute($execArray)) {
					$db->rollBack();
//					  return false;
					return array(false, $qString, implode(',', $localMembers));
				}
			}
		}

		// Save changes to the ring images
		if ($this->modifiedImages) {
			$localImages = $this->imageIds;

			$query = $db->prepare("SELECT image_id FROM ring_images WHERE ring_id=?");
			$query->execute(array($this->id));
			$dbImages = $query->fetchAll(PDO::FETCH_NUM);

			// If an image exists in both arrays, we don't need to add or remove it, so unset it in both arrays
			foreach ($dbImages as $index1 => $member) {
				$index2 = array_search($member, $localImages);
				if ($index2 !== false) {
					unset($dbImages[$index1], $localImages[$index2]);
				}
			}

			// IDs left in $dbImages are members who need to be deleted from the DB
			$placeHolder = implode(',', array_fill(0, count($dbImages), '?'));
			$query = $db->prepare("DELETE FROM ring_images WHERE image_id IN ($placeHolder)");
			if (!$query->execute(array($dbImages))) {
				$db->rollBack();
				return false;
			}

			// IDs left in $localImages are members who need to be added to the DB
			$placeHolder = implode('', array_fill(0, count($localImages), "$this->id,?),("));
			$query = $db->prepare("INSERT INTO ring_images (ring_id, image_id) VALUES ($placeHolder)");
			if (!$query->execute(array($localImages))) {
				$db->rollBack();
				return false;
			}
		}

		$db->commit();
//		  return true;
		return array(true, "", array());
	}
}
