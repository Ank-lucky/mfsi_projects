<cfif structKeyExists(Session,"loggedInUser") AND Session.loggedInUser.isUserLoggedIn EQ true>
<!---websocket initialisation--->
<!--- <cftry> --->
<!--- <cfwebsocket name="chatWebsock" onMessage="processOnMessage" subscribeTo="chatChannel"/> --->
<!--- <script> --->
<!--- 	function processOnMessage(event,msg){ --->
<!--- 			console.log(event,msg); --->
<!--- 	} --->
<!--- </script> --->
<!--- <cfcatch type="any"> --->
<!--- 	<cfdump var="#cfcatch.type#"> --->
<!--- 	<cfdump var="#cfcatch.message#"> --->
<!--- </cfcatch> --->
<!--- </cftry> --->
<!---Template of the chat Room--->

<!DOCTYPE html>
<html lang="en" >

<head>
  <meta charset="UTF-8">
  <title>Chat Template</title>


  <link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.0.10/css/all.css'>
  <link rel="stylesheet" href="../CSS/chatPageStyle.css">
  <script src="../JS/jquery-1.12.4.min.js"></script>
  <script rel="text/javascript" src="../../Controller/UserProfile.js"></script>

</head>

<body>

  <div id="wrapper">
  <aside id="left-sidebar">
	<div id="userProfile">
		<div class="userDisplay">
			<img id="dpImage" src="" alt="ProfilePic">
			<div id="userDesription">
				<p id="userName"><cfoutput>#Session.loggedInUser.userName#</cfoutput></p>
				<p id="status">Online</p>
        <input type="hidden" id="userId" value=<cfoutput>#Session.loggedInUser.userId#</cfoutput>>

			</div>
		</div>
    <div id="profileUpdate">

			<input  type="text" id="fullName" />
			<input  type="text" id="emailId" onkeyup="validatEmail()"/>
			<input  type="text" id="gender" />
      <input  type="text" id="address" />
      <form action="../../Controller/CF/UploadDisplayPic.cfm" enctype="multipart/form-data" method="POST" name="uploadDp">
      <label id="uploadPic">Upload Profile Picture:</label>
		  <input type="file" name="profilePic" id="profilePic" />
      <button type="submit" name="uploadPicform" id="uploadBtn">Upload</button>
      </form>
      <button id="updateButton" onclick="updateUserProfile();">Update</button>

		</div>
	</div>
	    <!--- <div class="search"> -->
	<!--       <input type="search" class="field" placeholder="Search"> -->
	<!--       <button class="btn"> -->
	<!--         <i class="fas fa-search"></i> -->
	<!--       </button> -->
	<!--     </div> --->
	<hr>
    <div id="users-container">
      <ul class="contactList" id="contactList">

        <!--- <li id="list">
          <!--- <a href="#">
            <div class="avatar">
              <img src="https://picsum.photos/71/71/" alt="">
            </div>
            <div class="description" id="description">
              <!--- <p><strong>User Name</strong></p> --->
            </div>
          </a> --->
        </li> --->

      </ul>
    </div>
    <div class="lastRow" >
      <div id="addContacts">
        <button class="lastRowButtons" id="addContactsBtn"class="modalButtons">ADD CONTACTS</button>
       </div>
      <div id="logout">
        <button class="lastRowButtons"><a href="../../Controller/CF/Login.cfm?logout=true">LOGOUT</a></button>
      </div>
    </div>
  </aside>
  <main id="content">
    <div class="chatHeader">
      <img id="friendDp" src="">
      <span id="friendName"><span>
    </div>
    <button id="pdfBtn" >Pdf</button>
    <ul id="user-message-container-list">
    <!--- <div class="user-message-container"> --->

      <!--- <div class="user-message-avatar">
        <img src="https://picsum.photos/65/65/" alt="">
      </div>
      <div class="user-message">
        <span class="user-name">Som..</span>
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
        <span class="user-date">10.10.2018 14:20PM</span>
      </div> --->
    <!--- </div> --->
  </ul>
    <div class="message-input">
			<div class="wrap">
			<input type="text" id="wrapInput" placeholder="Write your message..." />
			<button class="submit" onclick="newMessage()"><i class="fa fa-paper-plane " aria-hidden="true"></i></button>
			</div>
	</div>

  </main>
</div>

 <!---Modal for add Contact--->
 <div id="myModal" class="modal">
  <div class="modal-content">
    <div class="modal-header">
      <span class="close">&times;</span>
      <h2>Search And Add Contacts</h2>
    </div>
    <div class="modal-body">
      <div class="example" style="margin:auto;max-width:300px">
        <input type="text" placeholder="Enter UserName/EmailId" id="searchContact" onkeyup="searchToAddContact()">
        <button type="button" onclick="searchToAddContact()"><i class="fa fa-search"></i></button>
      </div>
      <div id="searchedContacts">
      </div>
    </div>
  </div>

</body>
<script rel="text/javascript" src="../JS/animate.js"></script>
</html>

<cfif isDefined("url.uploadedPicSuccessfully")>
<cfif url.uploadedPicSuccessfully EQ true>
	<script>
		alert("Successfully Uploaded your profile picture");
	</script>
<cfelse>
	<script>
		alert("Sorry couldn't upload your profile picture");
	</script>

</cfif>
</cfif>

<cfelse>
	<cflocation url="../../index.cfm?loginAgain=true" addtoken="no">
</cfif>
