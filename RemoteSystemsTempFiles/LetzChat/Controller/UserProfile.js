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
	element = "";
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
	// var emailId = document.getElementById("emailId").value;
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

	if(validate(name,address)){
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
			console.log("resp",response);
			if(response == true)
			console.log("successUpdating");
			else
			console.log("failedUpdating");
			// location.reload(true);
		},
		error: function(response){
			console.log(response);
		}
	});
	}
	else{
		return false;
	}

}

/*Function to validate while updating user profile */
function validate(name,address){
	 console.log("validate",name[0],name[1],name[2],address[0],address[1],address[2]);
	 var errMsg="";
	 regExpName=/[^\s][^\\s]*[^\s\s]*/;
	if(name[0]==undefined || (name[1]=="NULL" && name[2]==undefined )|| name[0]===" " ||name[1]===" "){
		errMsg = "Please Enter both FirstName and LastName";
		document.getElementById("fullName").placeholder=errMsg;
		alert(errMsg);
		return false;
	}
	for(let ind=0;ind<3;ind++){
		console.log("address[ind]",address[ind]);
		regExp=/[^,\s][^\,]*[^,\s]*/;
		if(address[ind] == ""|| address[ind] ==" " || address[ind] == undefined || !(regExp.test(address))){
		console.log("address[ind]",address[ind]);
		errMsg="Enter a proper city,state and country separated with comma and n space.";
		alert(errMsg);
		return false;
		}
	}
	return true;
	
}
function validatEmail(){
	alert("You can't change your email-id");
}

/* Function to search for contacts to be added */
function searchToAddContact() {
	console.log("addContact");
	var keyword=document.getElementById("searchContact").value;
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
		error: function(response){
			console.log("error",response);
		}
	});
}
function showSearchContactList(response){
	response = $.parseJSON(response);
	console.log(response);
	var contactElement= "";
	if(response.DATA.length != 0){
		for(let i=0;i<response.DATA.length;i++){
			contactElement+="<div style="+"display:flex;flex-direction:row;justify-content:space-between;padding:2%;"+"<p><strong>"+response.DATA[i][1]+"</strong></p><img id="+"addPeople"+" style="+"width:10%;height:5%;"+" src="+"../../View/images/addContact.png"+" onclick="+"addContact("+response.DATA[i][0]+")></div><hr>";
		}
		document.getElementById("searchedContacts").innerHTML=contactElement;
	}
	else
	document.getElementById("searchedContacts").innerHTML="<p style="+"font-size:1.5em;color:#0e73b1c4"+"><strong>"+"Sorry,your searched contact is not found!"+"<strong></p>";

}
//an add button to trigger addContact
function addContact(friendId){
	console.log("addContact",friendId);
	$.ajax({
		url: "../../Model/Components/UserProfile.cfc",
		data: {
			method: "addContact",
			userId: accountId,
			friendId: friendId
		},
		type: "POST",
		success: function(resp){
				 console.log("success",resp);
				 location.reload(true);
				//  if(resp == true){
				// 	element +="<li id="+"list"+"><div class="+"friend"+"><p><strong>"+userName+"<strong></p></div></li>"
				// 	document.getElementById("contactList").innerHTML = element;
				// }
				
		},
		error: function(response){
			console.log("error",response);
		}
	});
}

// $(".friend").on('click',function(){
// 	console.log("friend1");
// });
function openChatRoom(userName){
	// document.getElementById("friendName").innerHTML=userName;
}
