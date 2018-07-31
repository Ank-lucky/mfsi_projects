
<cfif structKeyExists(Session,"loggedInUser") AND Session.loggedInUser.isUserLoggedIn EQ "true">
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
  <script rel="text/javascript" src="../JS/animate.js"></script>

</head>

<body>

  <div id="wrapper">
  <aside id="left-sidebar">
	<div id="userProfile">
		<div class="userDisplay">
			<img  src="https://picsum.photos/71/71/" alt="">
			<div id="userDesription">
				<p id="userName"><cfoutput>#Session.loggedInUser.userName#</cfoutput></p>
				<p id="status">Online</p>
				<input type="hidden" id="userId" value=<cfoutput>#Session.loggedInUser.userId#</cfoutput>>
			</div>
		</div>
		<div id="profileUpdate">
			<input  type="text" id="fullName" />
			<input  type="text" id="emailId" />
			<input  type="text" id="gender" />
			<input  type="text" id="address" />
			<button id="updateButton" onclick="updateUserProfile();">Update</button>
		</div>
	</div>
    <div class="search">
      <input type="search" class="field" placeholder="Search">
      <button class="btn">
        <i class="fas fa-search"></i>
      </button>
    </div>
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
        <button class="lastRowButtons" id="addContactsBtn" >ADD CONTACTS</button>
      </div>
      <div id="logout">
        <button class="lastRowButtons">LOGOUT</button>
      </div>
    </div>
  </aside>
  <main id="content">

    <div class="user-message-container">
      <div class="user-message-avatar">
        <img src="https://picsum.photos/65/65/" alt="">
      </div>
      <div class="user-message">

        <span class="user-name">Alex</span>

        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
        <span class="user-date">10.10.2018 14:20PM</span>
      </div>
    </div>

    <div class="user-message-container">
      <div class="user-message-avatar">
        <img src="https://picsum.photos/66/66/" alt="">
      </div>
      <div class="user-message">

        <span class="user-name">Mozart</span>

        Consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
        <span class="user-date">10.10.2018 14:21PM</span>
      </div>
    </div>


    <div class="user-message-container">
      <div class="user-message-avatar">
        <img src="https://picsum.photos/66/66/" alt="">
      </div>
      <div class="user-message">

        <span class="user-name">Biba</span>
        Ziga!!!

        <span class="user-date">10.10.2018 14:22PM</span>
      </div>
    </div>


  </main>
</div>
  <div id="myModal" class="modal">
    <!-- Modal content -->
    <div class="modal-content">
      <div class="modal-header">
        <span class="closed">
          &times;
        </span>
        <h2>
          Add Contact
        </h2>
      </div>
      <div class="modal-body">
        <!---Search bar and a list of contacts to be added, retrieve all those users--->
      </div>
    </div>
  </div>
</body>

</html>

<cfelse>
	<cflocation url="../../index.cfm?loginAgain=true" addtoken="no">
</cfif>
