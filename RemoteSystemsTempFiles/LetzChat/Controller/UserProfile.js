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

});

/*rendering userDetail in frontend */
function handleUserDetail(details) {

	console.log(JSON.parse(details));
	var element = "";
	var userDetailsJson = JSON.parse(details);
		if(userDetailsJson.MiddleName != "NULL")
		document.getElementById("fullName").value = userDetailsJson.FirstName+" "+userDetailsJson.MiddleName+" "+userDetailsJson.LastName;
		else{
			document.getElementById("fullName").value = userDetailsJson.FirstName+" "+userDetailsJson.LastName;
		}
		document.getElementById("emailId").value = userDetailsJson.EmailId;
		document.getElementById("gender").value = userDetailsJson.Gender;
		document.getElementById("address").value = userDetailsJson.City + "," + userDetailsJson.State + "," + userDetailsJson.Country;
		// document.getElementById("profile-img").src=userDetailsJson.Imagepath;
		var element = "";
		if(userDetailsJson.friends.friends != "NULL"){
		for (key in userDetailsJson.friends) {
			console.log(userDetailsJson.friends[key]);
			// element += "<div class=" + "wrap" + " onclick=" + "chatFriend() ><span class=" + "contact-status online" + "></span><img src=" + "" + "/><div class=" + "meta" + "<p id=" + key + " class=" + "name" + ">" + userDetailsJson.friends[key].UserName + "</p><p class=" + "preview" + "></p></div></div><br>";
			// element +="<a href="+"#"+"><div class="+"avatar"+"> <img src="+"https://picsum.photos/71/71/"+"></div><div class="+"description"+"><p><strong>"+userDetailsJson.friends[key].UserName+"<strong></p></div></a>"
			element +="<li id="+"list"+"><div class="+"friend"+"><p><strong>"+userDetailsJson.friends[key].UserName+"<strong></p></div></li>"
		}
		}
		else{
			element ="<div class="+"noContactMsg"+">No friends yet to chat! Add friends and chat..</div>"
		}
		document.getElementById("contactList").innerHTML = element;
	
}

/*Function to update the user profile  */
function updateUserProfile() {
	console.log("update Profile");
	var fullName = document.getElementById("fullName").value;
	var emailId = document.getElementById("emailId").value;
	var addr = document.getElementById("address").value;
	var name = fullName.split(" ",3);
	var address = addr.split(",", 3);
	
	var firstName = name[0];
	var middleName;
	var lastName;
	console.log(name.length);
	if (name.length != 2) {
		middleName = name[1];
		lastName = name[2];	
	}
	else {
		middleName = "NULL";
		lastName = name[1];
	}
	console.log(firstName,middleName,lastName,"emailId",emailId,address[2],address[1],address[0]);
	$.ajax({
		url: "../../Model/Components/UserProfile.cfc",
		data: {
			method: "updateUserDetails",
			userId: accountId,
			firstName: firstName,
			middleName: middleName,
			lastName: lastName,
			emailId: emailId,
			country: address[2],
			state: address[1],
			city: address[0]
		},

		dataType: 'json',
		type: "POST",
		success: function (response) {
			console.log("resp", response);
			if (response == true)
				console.log("successUpdating");
			else
				console.log("failedInUpdating");
		},
		error: function(response){
			console.log(response);
		}
	});

}

/* Function to search for contacts to be added */
function searchToAddContact() {
	console.log("addContact");
	var keyWord="Sonal"
	$.ajax({
		url: "../../Model/Components/UserProfile.cfc",
		data: {
			method: "searchToAddContact",
			userId: accountId,
			keyWord: keyWord
		},
		dataType:'json',
		type: "POST",
		success: showSearchContactList
	});
}
function showSearchContactList(response){
	console.log(response);
}
function chatFriend(friendDetails) {
	console.log(friendDetails);
}