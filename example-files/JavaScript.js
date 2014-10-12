// Globals
var originalList = {}, modifiedList = {};
var originalListString = null;
var originalName = null;
var ringID = null;

$(function() {
    var urlVars = location.search.substring(1).split('&');
    ringID = urlVars[0].split('=')[1];
    var data = {ring: ringID,
                user: getCookie('userId')};

    // Make the ringDisplay a square
//    $("#ringDisplay").height($("#ringDisplay").width());

//    console.log(data);

    // Store the original ring name.
    originalName = $('#ringName').val();

    $.ajax({
        type: "POST",
        url: "getRingData.php",
        data: data,
        dataType: 'json',
        success: function(data) {
//            console.log("Success");
            console.log(data);
//            console.log(data['members']);

            members         = data['members'];
            others          = data['otherFriends'];
            localMembers    = members.slice(0);
            localOthers     = others.slice(0);

            for (var i = 0; i < members.length; i++) {
                var index = members[i]['id'];
                originalList[index] = true;
                modifiedList[index] = true;
                var memberItem = $("#memberTemplate").clone();
                memberItem.removeClass('template');
                memberItem.addClass('member-list-item');
                memberItem.attr('id', 'person_'+members[i]['id']);
                memberItem.find('button').attr('onclick', 'removeMember('+members[i]['id']+')');
                memberItem.find('p').append(members[i]['name']);
                $("#members").append(memberItem);
            }

            for (var i = 0; i < others.length; i++) {
                var index = others[i]['id'];
                originalList[index] = false;
                modifiedList[index] = false;
                var otherItem = $("#otherFriendTemplate").clone();
                otherItem.removeClass('template');
                otherItem.addClass('member-list-item');
                otherItem.attr('id', 'person_'+others[i]['id']);
                otherItem.find('button').attr('onclick', 'addMember('+others[i]['id']+')');
                otherItem.find('p').append(others[i]['name']);
                $("#otherFriends").append(otherItem);
            }

            $("#ringDisplay > p").text(members.length + " Members");

            var interval = 2 * Math.PI / members.length;
            var theta = Math.PI / 2;
            var halfWidth = $("#ringDisplay").width() / 2;
            var halfHeight = $("#ringDisplay").height() / 2;
            var imgRadius = 32;
            var paddingLeft = parseInt($("#ringDisplay").css('padding-left'));
            var paddingTop = parseInt($("#ringDisplay").css('padding-top'));

            // Trigonometric functions for the image locations where `radius` is the radius of the bounding box
            // top:     radius - (radius - imgRadius)sin(theta)
            // left:    radius + (radius - imgRadius)cos(theta)
            var animations = [];
            for (var i = 0; i < members.length; i++) {
                var topOffset = halfHeight - ((halfHeight - imgRadius) * Math.sin(theta)) + paddingTop;
                var leftOffset = halfWidth + ((halfWidth - imgRadius) * Math.cos(theta)) + (imgRadius - paddingLeft/2);
                theta += interval;
                var image = $("#ringImgTemplate").clone();
                image.removeClass("template");
                image.addClass("img-circle");
                image.attr("id", "profileImg_"+members[i]['id']);
                image.attr("src", members[i]['profile_image']);
                image.css('top', topOffset + 'px');
                image.css('left', leftOffset + 'px');
                $("#ringDisplay").append(image);
                image.hide();
                animations.push(image);
            }

            // Finish up
            finishInitializingThePage();
            doQueuedAnimations(animations, 500 / animations.length);
        },
        error: function(data) {
            console.log("ERROR");
            console.log(data);
        }
    });
});

function doQueuedAnimations(animations, speed) {
    speed |= 0;   // Truncate all digits after the decimal point
    if (animations.length > 0) {
        animations.shift().fadeIn(speed, function() {
            doQueuedAnimations(animations, speed);
        });
    }
//    console.log(speed);
}

function getCookie(name) {
    var parts = document.cookie.split(name + '=');
    if (parts.length == 2) {
        return parts.pop().split(';').shift();
    }
    return false;
}

function removeMember(id) {
    console.log("Removing person " + id + ".");
    var member = $('#person_'+id);

    // Remove from the members list
    member.detach();

    // Alter the necessary classes
    member.find('button').attr('onclick', 'addMember('+id+')');
    member.find('i').removeClass('fa-minus').addClass('fa-plus');

    // Add to the otherFriends list
    $('#otherFriends').append(member);

    // Check if changes need to be saved
//    console.log(modifiedList[id]);
    updateMemberList(id);
//    console.log(modifiedList[id]);
    needToSave();
}

function addMember(id) {
    console.log("Adding person " + id + ".");
    var member = $('#person_'+id);

    // Remove from the members list
    member.detach();

    // Alter the necessary classes
    member.find('button').attr('onclick', 'removeMember('+id+')');
    member.find('i').removeClass('fa-plus').addClass('fa-minus');

    // Add to the otherFriends list
    $('#members').append(member);

    // Check if changes need to be saved
//    console.log(modifiedList[id]);
    updateMemberList(id);
//    console.log(modifiedList[id]);
    needToSave();
}

function saveChanges() {
    // Make sure we actually need to save
    if (needToSave()) {
        console.log("Saving...");
        // TODO
        var newData = { ring: ringID,
                        user: getCookie('userId'),
//                        members: JSON.stringify(modifiedList),
                        members: modifiedList,
                        name: $('#ringName').val()};

        $.ajax({
            type: "POST",
            url: "saveRingChanges.php",
            data: newData,
            dataType: 'json',
            success: function(data) {
                console.log("Success");
                console.log(data);
                location.reload();
            },
            error: function(data) {
                console.log("ERROR");
                console.log(data);
            }
        });
    }
}

function needToSave() {
    // Enable or Disable the button
    if (originalListString !== JSON.stringify(modifiedList) || $('#ringName').val() != originalName) {
        $('#saveButton').addClass('btn-warning').removeAttr('disabled');
        return true;
    } else {
        $('#saveButton').removeClass('btn-warning').attr('disabled', 'disabled');
        return false;
    }
}

function updateMemberList(id) {
    modifiedList[id] = !modifiedList[id];
}

function finishInitializingThePage(){
    // Stringify the orignialList so we don't have to re-stringify it every time we check if we need to save
    originalListString = JSON.stringify(originalList);

    // Bind needToSave() to the onChange state of the ring name form
    $("#ringName").bind('input', function() {
        needToSave();
    });
}