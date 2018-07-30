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
	var i = 0;
	var friendArray = [];
	console.log(JSON.parse(details));
	var element = "";
	var userDetailsJson = JSON.parse(details);

	if (userDetailsJson.friends != "NULL") {
		document.getElementById("userName").innerHTML = userDetailsJson.UserName;
		document.getElementById("fullName").value = userDetailsJson.FirstName + " " + userDetailsJson.MiddleName + " " + userDetailsJson.LastName;
		document.getElementById("emailId").value = userDetailsJson.EmailId;
		document.getElementById("gender").value = userDetailsJson.Gender;
		document.getElementById("address").value = userDetailsJson.City + "," + userDetailsJson.State + "," + userDetailsJson.Country;
		// document.getElementById("profile-img").src=userDetailsJson.Imagepath;
		var element = "";
		for (key in userDetailsJson.friends) {

			console.log(userDetailsJson.friends[key]);
			element += "<div class=" + "wrap" + " onclick=" + "chatFriend() ><span class=" + "contact-status online" + "></span><img src=" + "" + "/><div class=" + "meta" + "<p id=" + key + " class=" + "name" + ">" + userDetailsJson.friends[key].UserName + "</p><p class=" + "preview" + "></p></div></div><br>";
		}
		document.getElementById("contactList").innerHTML = element;
	}
	else {
		document.getElementById("contactList").innerHTML = element;
	}

}
/* Function to search for contacts to be added */
function searchToAddContact() {
	console.log("addContact");
	$.ajax({
		url: "../../Model/Components/UserProfile.cfc",
		data: {
			method: "searchToAddContact",
			userId: accountId
		},
		dataType:'json',
		type: "POST",
		success: showSearchContactList
	});
}
function showSearchContactList(response){
	console.log(response);
}
/*Function to update the user profile  */
function updateProfile() {
	console.log("update Profile");
	var fullName = document.getElementById("fullName").value;
	var emailId = document.getElementById("emailId").value;
	var addr = document.getElementById("address").value;
	var name = fullName.split(" ", 4);
	var address = addr.split(",", 3);

	var firstName = name[0];
	var middleName;
	var lastName;
	if (name.length == 3) {
		middleName = "NULL";
		lastName = name[2];
	}
	else {
		middleName = name[2];
		lastName = name[3];
	}
	// console.log("emailId",emailId);
	console.log("uid", accountId);
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
		success: function () {
			console.log("resp", response);
			if (response == true)
				console.log("success");
			else
				console.log("failed");
		}
	});

}
function chatFriend(friendDetails) {
	console.log(friendDetails);
}