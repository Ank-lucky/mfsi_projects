$(document).ready(function () {
	accountId = $("#userId").val();
	console.log("acc", accountId);
	/*Ajax call retrieve userdetails */
	$.ajax({
		url: "../../Model/Components/UserProfile.cfc",
		data: {
			method: "retrieveUserDetails",
			userId: accountId
		},

		type: "POST",
		success: handleUserDetail
	});

	setInterval(()=>{
		if(friendCount != 0 && selectedFriendId !== undefined){
			console.log("slc",selectedFriendId);	
		openChatRoom(selectedFriendId,selectedFriendImage);}
	},5000)
	

	$("#pdfBtn").on('click',function(){
		window.open("../../Controller/CF/pdfGenerator.cfm?selectedFriendId="+selectedFriendId);
	})

});
var userImage;
var selectedFriendId;
var selectedFriendImage;
var friendCount=0;
/*rendering userDetail in frontend */
function handleUserDetail(details) {

	console.log(JSON.parse(details));
	element = "";
	var userDetailsJson = JSON.parse(details);
	if (userDetailsJson.MiddleName != "NULL")
		document.getElementById("fullName").value = userDetailsJson.FirstName + " " + userDetailsJson.MiddleName + " " + userDetailsJson.LastName;
	else {
		document.getElementById("fullName").value = userDetailsJson.FirstName + " " + userDetailsJson.LastName;
	}
	document.getElementById("emailId").value = userDetailsJson.EmailId;
	document.getElementById("gender").value = userDetailsJson.Gender;
	document.getElementById("address").value = userDetailsJson.City + "," + userDetailsJson.State + "," + userDetailsJson.Country;
	// document.getElementById("profile-img").src=userDetailsJson.Imagepath;
	$("#dpImage").attr('src','../../View/images/uploadPic/'+userDetailsJson.Imagepath+".jpg");
	userImage=userDetailsJson.Imagepath;
	var element = "";
	if (userDetailsJson.friends.friends != "NULL") {
		for (key in userDetailsJson.friends) {
			console.log("frns:", userDetailsJson.friends[key]);
			element += "<li id=" + "list" + "><div class=" + "friend" + " onclick=" + "openChatRoom(" + userDetailsJson.friends[key].FriendId +","+"\""+userDetailsJson.friends[key].Imagepath+"\""+"); ><p><strong>" + userDetailsJson.friends[key].UserName + "<strong></p></div></li>"
			friendCount++;
		}
	}
	else {
		element = "<div class=" + "noContactMsg" + ">No friends yet to chat! Add friends and chat..</div>"
	}
	document.getElementById("contactList").innerHTML = element;

}

/*Function to update the user profile  */
function updateUserProfile() {
	console.log("update Profile");
	var fullName = document.getElementById("fullName").value;
	// var emailId = document.getElementById("emailId").value;
	var addr = document.getElementById("address").value;
	var name = fullName.split(" ", 3);
	var address = addr.split(",", 3);
	var firstName = name[0];
	var middleName;
	var lastName;
	console.log(name);
	console.log(name.length);
	if (name.length != 2) {
		if (name[1] != "") {
			middleName = name[1];
		} else {
			middleName = "NULL";
		}
		lastName = name[2];
	}
	else {
		middleName = "NULL";
		lastName = name[1];
	}
	console.log(firstName, middleName, lastName, "emailId", emailId, address[2], address[1], address[0]);

	if (validate(name, address)) {
		$.ajax({
			url: "../../Model/Components/UserProfile.cfc",
			data: {
				method: "updateUserDetails",
				userId: accountId,
				firstName: firstName,
				middleName: middleName,
				lastName: lastName,
				country: address[2],
				state: address[1],
				city: address[0]
			},
			type: "POST",
			success: function (response) {
				console.log("resp", response);
				if (response == true)
					console.log("successUpdating");
				else
					console.log("failedUpdating");
				// location.reload(true);
			},
			error: function (response) {
				console.log(response);
			}
		});
	}
	else {
		return false;
	}

}

/*Function to validate while updating user profile */
function validate(name, address) {
	console.log("validate", name[0], name[1], name[2], address[0], address[1], address[2]);
	var errMsg = "";
	// regExpName = /[a-zA-z]+\s+([a-zA-z]\s)?[a-zA-z]+/;
	regExpName=/^\w\s(\w\s)?\w$/;
	console.log(regExpName);
	
	 if(!regExpName.test(name)){
		console.log("in name");
		errMsg = "Please Enter both FirstName and LastName";
		document.getElementById("fullName").placeholder = errMsg;
		alert(errMsg);
		return false;
	}
	for (let ind = 0; ind < 3; ind++) {
		console.log("address[ind]", address[ind]);
		regExp = /[^,\s][^\,]*[^,\s]*/;
		if (address[ind] == "" || address[ind] == " " || address[ind] == undefined || !(regExp.test(address))) {
			console.log("address[ind]", address[ind]);
			errMsg = "Enter a proper city,state and country separated with comma and n space.";
			alert(errMsg);
			return false;
		}
	}
	return true;

}
function validatEmail() {
	alert("You can't change your email-id");
}

/* Function to search for contacts to be added */
function searchToAddContact() {
	console.log("addContact");
	var keyword = document.getElementById("searchContact").value;
	console.log(keyword);
	$.ajax({
		url: "../../Model/Components/UserProfile.cfc?queryformat=column",
		data: {
			method: "searchToAddContact",
			userId: accountId,
			keyWord: keyword
		},
		type: "POST",
		success: showSearchContactList,
		error: function (response) {
			console.log("error", response);
		}
	});
}
function showSearchContactList(response) {
	response = $.parseJSON(response);
	console.log(response);
	var contactElement = "";
	if (response.DATA.length != 0) {
		for (let i = 0; i < response.DATA.length; i++) {
			contactElement += "<div style=" + "display:flex;flex-direction:row;justify-content:space-between;padding:2%;" + "<p><strong>" + response.DATA[i][1] + "</strong></p><img id=" + "addPeople" + " style=" + "width:10%;height:5%;" + " src=" + "../../View/images/addContact.png" + " onclick=" + "addContact(" + response.DATA[i][0] + ")></div><hr>";
		}
		document.getElementById("searchedContacts").innerHTML = contactElement;
	}
	else
		document.getElementById("searchedContacts").innerHTML = "<p style=" + "font-size:1.5em;color:#0e73b1c4" + "><strong>" + "Sorry,either your searched contact is not using LetzChat or he/she is already in your contact!" + "<strong></p>";

}
//an add button to trigger addContact
function addContact(friendId) {
	console.log("addContact", friendId);
	$.ajax({
		url: "../../Model/Components/UserProfile.cfc",
		data: {
			method: "addContact",
			userId: accountId,
			friendId: friendId
		},
		type: "POST",
		success: function (resp) {
			console.log("success", resp);
			location.reload(true);
		},
		error: function (response) {
			console.log("error", response);
		}
	});
}

var chatId;
function openChatRoom(friendId,image) {
	console.log("userId", accountId, "friendId", friendId,image);
	selectedFriendId=friendId;
	selectedFriendImage=image;
	$("#content").css("display","block");
	$("#friendDp").attr("src","../../View/images/uploadPic/"+selectedFriendImage+".jpg");
	$.ajax({
		url: "../../Model/Components/UserProfile.cfc?queryformat=column",
		data: {
			method: "openChatRoom",
			userId: accountId,
			friendId: friendId,
			groupId: "NULL"
		},
		type: "POST",
		success: function (response) {
			console.log($.parseJSON(response));
			var recieverDetails = $.parseJSON(response);
			document.getElementById("friendName").innerHTML = recieverDetails.DATA[0][2];
			chatId = recieverDetails.DATA[0][0];
			getConversation( recieverDetails.DATA[0][1],recieverDetails.DATA[0][2],image);
		},
		error: function (response) {
			console.log("error:", response);
		}
	})
	// document.getElementById("friendName").innerHTML=userName;
}

/*show send message */
var elem = "";
var message = "";
function newMessage() {
	message = $(".message-input input").val();
	if ($.trim(message) == '') {
		return false;
	}

	$('.message-input input').val(null);

	/*Send message*/
	console.log("msg:",message,chatId);
	$.ajax({
		url: "../../Model/Components/GetAndSendMessage.cfc",
		data: {
			method:"sendMessage",
			chatId:chatId,
			message:message
		},
		type: "POST",
		success: function (response) {
			console.log(response);
		},
		error: function (response) {
			console.log("error:", response);
		}
	})
	openChatRoom(selectedFriendId,selectedFriendImage);
};

$(window).on('keypress', function (e) {
	if (e.which == 13) {
		newMessage();
		return false;
	}
});

function getConversation(friendId,friendName,image) {
	$.ajax({
		url: "../../Model/Components/GetAndSendMessage.cfc?queryformat=column",
		data: {
			method:"getMessage",
			userId:accountId,
			friendId:friendId
		},
		type: "POST",
		success: function (msgs) {
			renderMessagesInChatRoom(msgs,friendName,image);
		},
		error: function (response) {
			console.log("error:", response);
		}

	})
}
function renderMessagesInChatRoom(msgs,sender,image){
	var jsonMsg=JSON.parse(msgs);
	console.log("msgs:",jsonMsg);
	var renderMsg="";
	for(let i=0 ;i<jsonMsg.length;i++){
		
		if(accountId != jsonMsg[i].SenderId){
			
			renderMsg += "<div class=" + "user-message-container" + "><div class=" + 
			"user-message-avatar" + "> <img src=" + "../images/uploadPic/"+image+".jpg"+" alt="+"Dp"+
			 "></div><div style="+"background-color:#65b1bf;color:#fff"+" class=" + "user-message" + ">" +
			"<span class=" + "user-name" + ">"+sender+" </span><p>" + jsonMsg[i].Message + "</p><span class=" 
			+ "user-date" + ">"+jsonMsg[i].RecieveTime+"</span></div></div>";
		}
		else{
					renderMsg+="<div class=" + "user-message-container" + "><div class=" + 
					"user-message-avatar" + "> <img src=" + "../images/uploadPic/"+userImage+".jpg"+" alt="+"Dp"+
					 "></div><div class=" + "user-message" + ">" +
					"<span class=" + "user-name" + ">You </span><p>" + jsonMsg[i].Message + "</p><span class=" 
					+ "user-date" + ">"+jsonMsg[i].SentTime+"</span></div></div>";
				}
	}
	document.getElementById("user-message-container-list").innerHTML = renderMsg;
}


