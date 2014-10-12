<?php
require_once 'libs/UserAuth.php';
require_once 'libs/Profile.php';

$auth = new UserAuth();
$passwordSuccess = "display:none;";
$passwordFailed = "display:none;";
// If the user is not logged in, redirect them to the splash page
if ($auth->isLoggedIn($_SESSION['loggedIn']) == false) {
    header("Location: index.php");
}

//print_r($_POST);

if ($_POST['action'] == 'changePassword') {
    if ($auth->changePassword($_SESSION['username'], $_POST['oldPassword'], $_POST['newPassword'])) {
        //TODO alert the user that their password was successfully changed
		$passwordSuccess = "display:inherit;";	
		
    } else {
        //TODO alert the user that their password was not changed
		//echo 'Password not changed';
		$passwordFailed = "display:inherit;";
    }
}

$profile = new Profile();
$profile->buildFromUsername($_SESSION['username']);

?>

<!DOCTYPE html>
<html>
<head>
    <title>Profile Settings - PhotoRings</title>
    <link rel="shortcut icon" href="images/photorings_favicon.ico"/>
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.0.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="sidenav/sidenav.css">
    <link rel="stylesheet" href="css/dropzone.css">
    <link rel="stylesheet" href="css/profileSettings.css">	
    <script src="js/dropzone.min.js"></script>
    <script src="js/profileSettings.js"></script>
</head>



<body>
    <!-- Side navigation -->
    <div class="sidebar pull-left">
        <? include 'sidenav/sidenav.html' ?>
    </div>

    <!-- Main page content -->
    <div class="main">
        <div class="container">

            <!-- Profile Information Box -->
			<div class="alert alert-success" id="changeSuccess" style="<?php echo $passwordSuccess; ?>"><b>Your PASSWORD was successfully CHANGED!</b></div>
			<div class="alert alert-danger" id="changeFailed" style="<?php echo $passwordFailed; ?>"><b>Your PASSWORD was NOT CHANGED! Please check new passwords to see that they match.</b></div>
						
            <div class="row">
                <div class="panel panel-default">
                    <div class="panel-heading"><h4 class="panel-title">Your Profile Information</h4></div>
                    <div class="panel-body">
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label class="col-md-3 control-label">Name</label>
                                <div class="col-md-9">
                                    <p class="form-control-static"><? echo $profile->getFullName(); ?></p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Email</label>
                                <div class="col-md-9">
                                    <p class="form-control-static"><? echo $_SESSION['username']; ?></p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Birthdate</label>
                                <div class="col-md-9">
                                    <p class="form-control-static"><? echo $profile->getPrettyDob(); ?></p>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div> <!-- END Profile Information Box -->

            <!-- Change Profile Picture Form -->
            <div class="row">
                <div class="panel panel-default">
                    <div class="panel-heading"><h4 class="panel-title">Change Profile Picture</h4></div>
                    <div id="profileImgPanel" class="panel-body">
                        <div id="profileImg" class="">
                            <img class="profile-img img-rounded" src="<? echo $profile->getProfilePictureURL(); ?>" alt="profile image"/>
                        </div>
                        <div id="dropzoneDiv" class="">
                            <form class="dropzone" action="uploadProfileImage.php" id="uploadDropzone">
                                <input type="hidden" name="username" value="<? echo $_SESSION['username']; ?>">
                                <div class="fallback">
                                    <input type="file" name="file"/>
                                </div>
                            </form>
                        </div>
                        <br>
                        <p class="text-center">You can upload images that are less than 5mb in size and have one of these extensions: .jpg, .jpeg, .png</p>
                    </div>
                </div>
            </div> <!-- END Change Profile Picture Form -->

            <!-- Password Change Form -->
            <div class="row">
                <div class="panel panel-default">
                    <div class="panel-heading"><h4 class="panel-title">Change Password</h4></div>
                    <div class="panel-body">
                        <form class="form-horizontal" role="form" action="profileSettings.php" method="post">
                            <input type="hidden" name="action" value="changePassword">
                            <div class="form-group">
                                <label for="oldPassword" class="col-md-3 control-label">Old Password</label>
                                <div class="col-md-9">
                                    <input type="password" class="form-control" id="oldPassword" name="oldPassword" placeholder="">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="newPassword" class="col-md-3 control-label">New Password</label>
                                <div class="col-md-9">
                                    <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="confirmNewPassword" class="col-md-3 control-label">Confirm New Password</label>
                                <div class="col-md-9">
                                    <input type="password" class="form-control" id="confirmNewPassword" name="confirmNewPassword" placeholder="">
                                </div>
                            </div>
							
							
							
							
                            <div class="form-group">
                                <div class="col-md-offset-3 col-md-9">
                                    <button type="submit" class="btn btn-default btn-submit">Update Password</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div> <!-- END Password Change Form -->

            <!-- Profile Stats Box -->
            <div class="row">
                <div class="panel panel-default">
                    <div class="panel-heading"><h4 class="panel-title">Your Profile Stats</h4></div>
                    <div class="panel-body">
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label class="col-md-3 control-label"># of Rings</label>
                                <div class="col-md-9">
                                    <p class="form-control-static"><? echo $profile->getRingCount(); ?></p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label"># of People in your Rings</label>
                                <div class="col-md-9">
                                    <p class="form-control-static"><? echo $profile->getFriendCount(); ?></p>
                                </div>
                            </div>
                            <hr style="border-color:#FFB000;">
                            <div class="form-group">
                                <label class="col-md-3 control-label">Image Directory</label>
                                <div class="col-md-9">
                                    <p class="form-control-static"><? echo $profile->getImageDirectory(); ?></p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label"># of Uploaded Images</label>
                                <div class="col-md-9">
                                    <p class="form-control-static"><? echo $profile->getImageCount(); ?></p>
                                </div>
                            </div>
                            <? $footprint = $profile->getDiskFootprint(); ?>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Size of Original Images</label>
                                <div class="col-md-9">
                                    <p class="form-control-static"><? echo $footprint[0]; ?></p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Size of Resized Images</label>
                                <div class="col-md-9">
                                    <p class="form-control-static"><? echo $footprint[1]; ?></p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Size of Profile Images</label>
                                <div class="col-md-9">
                                    <p class="form-control-static"><? echo $footprint[2]; ?></p>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div> <!-- END Profile Stats Box -->
        </div>
    </div>

    <!-- Get them scripts. Load them last to improve page loading speeds. -->
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
</body>
</html>
