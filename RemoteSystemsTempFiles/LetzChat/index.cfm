<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<title>
			Letz Chat
		</title>
		<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.8/css/materialize.min.css'>
		<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Pacifico'>
		<link rel='stylesheet' href='https://fonts.googleapis.com/icon?family=Material+Icons'>
		<link rel="stylesheet" href="View/css/style.css">
		<script rel="text/javascript" src="View/JS/jquery-1.12.4.min.js"></script>
		<script rel="text/javascript" src="View/JS/FetchCountriesStates.js"></script>
		<script rel="text/javascript" src="View/JS/validate.js"></script>
	</head>
	<body>
		<html>
			<head>
				<meta charset="utf-8">
				<title>
					Letz Chat
				</title>
			</head>
			<body class="login-body">
				<div class="row">
					<h4 style="text-align:center;margin-bottom:0">
						Letz Chat....
					</h4>
					<p id="message" style="text-align:center;color:green;margin:2% 30% 0% 30%">
					</p>
					<div class="input-cart col s12 m10 push-m1 z-depth-2 grey lighten-5">
						<!-- Login Form -->
						<div class="col s12 m5 login">
							<h4 class="center">
								Log in
							</h4>
							<br>
							<form action="Controller/CF/Login.cfm" method="POST"  >
								<div class="row">
									<div class="input-field">
										<input type="text" id="login" name="EmailOrUserName" required="required" class="validate" placeholder="Email/Username">
										<label for="user">
											<i class="material-icons">
												person
											</i>
										</label>
									</div>
								</div>
								<div class="row">
									<div class="input-field">
										<input type="password" id="passkey" name="Password" required="required" class="validate"  placeholder="Password">
										<label for="pass">
											<i class="material-icons">
												lock
											</i>
										</label>
									</div>
								</div>
								<div class="row">
									<div class="switch col s6">
										<label>
											<a href="#">
												Forgot Password
											</a>
										</label>
									</div>
									<div class="col s6">
										<button type="submit" name="Login" class="btn waves-effect waves-light blue right">
											Log in
										</button>
									</div>
								</div>
							</form>
						</div>
						<!-- Signup form -->
						<div class="col s12 m7 signup">
							<div class="signupForm">
								<h4 class="center">
									Sign up
								</h4>
								<br>
								<form action="Controller/CF/SignUp.cfm" name="signup" method="POST" onsubmit="return validate()" >
									<div class="row">
										<div class="input-field col s12 m6">
											<input type="text" id="firstName" name="FirstName" class="validate"  placeholder="Enter FirstName">
											<label for="name-picked">
												<i class="material-icons">
													person_add
												</i>
											</label>
											<span id="showErrorfName" class="ErrorMsg">
											</span>
										</div
											>
										<div class="input-field col s12 m6">
											<input type="text" id="middleName" name="MiddleName" class="validate" placeholder="Enter MiddleName">
											<span id="showErrorMidName" class="ErrorMsg">
											</span>
										</div>
										<div class="input-field col s12 m6">
											<input type="text" id="lastName" name="LastName" class="validate"placeholder="Enter LastName">
											<span id="showErrorlName" class="ErrorMsg">
											</span>
										</div>
									</div>
									<div class="row">
										<div class="input-field col s12 m6">
											<input type="text" id="userName" name="UserName" class="validate"  placeholder="Enter a username">
											<label for="name-picked">
												<i class="material-icons">
													person_add
												</i>
											</label>
											<span id="showErrorUserName" class="ErrorMsg">
											</span>
										</div>
									</div>
									<div class="row">
										<div class="input-field col s12 m6">
											<input type="date" id="dob" name="DOB" class="validate">
											<span id="showErrorDob" class="ErrorMsg">
											</span>
										</div>
									</div>
									<div class="row">
										<div class="dropdown col s12 m6">
											<select id="gender"name="Gender">
												<option>
													Select Gender
												</option>
												<option>
													Male
												</option>
												<option>
													Female
												</option>
											</select>
											<span id="showErrorGender" class="ErrorMsg">
											</span>
										</div>
									</div>
									<div class="row">
										<div class=" col s12 m4">
											<select id="country" name="Country">
											</select>
											<span id="showErrorCountry" class="ErrorMsg">
											</span>
										</div>
										<div class=" col s12 m4">
											<select id="state" name="State">
											</select>
											<span id="showErrorState" class="ErrorMsg">
											</span>
										</div>
										<div class=" col s12 m4">
											<select id="city" name= "City">
											</select>
											<span id="showErrorCity" class="ErrorMsg">
											</span>
										</div>
									</div>
									<div class="row">
										<div class="input-field PhoneNo">
											<div class="col s12">
												<input type="text" id="phoneNo" name="PhoneNo" class="validate" placeholder="Enter your phone no.">
											</div>
											<span id="showErrorPhoneNo" class="ErrorMsg">
											</span>
										</div>
									</div>
									<div class="row">
										<div class="input-field email">
											<div class="col s12">
												<input type="text" id="email" name="Email" class="validate" placeholder="Enter your email">
												<label for="email">
													<i class="material-icons">
														mail
													</i>
												</label>
												<span id="showErrorEmail" class="ErrorMsg">
												</span>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="input-field col s12 m6">
											<input type="password" id="password" name="Password" class="validate" placeholder="Password">
											<label for="pass-picked">
												<i class="material-icons">
													lock
												</i>
											</label>
											<span id="showErrorPassword" class="ErrorMsg">
											</span>
										</div>
										<div class="input-field col s12 m6">
											<input type="password" id="confrmPassword" name="ConfirmedPassword" class="validate" placeholder="Re-enter password">
											<label for="pass-picked">
												<i class="material-icons">
													lock
												</i>
											</label>
											<span id="showErrorCnfPassword" class="ErrorMsg">
											</span>
										</div>
									</div>
									<div class="row">
										<button type="submit" name="Register" class="btn blue right waves-effect waves-light" >
											Sign Up
										</button>
									</div>
								</form>
							</div>
							<div class="signup-toggle center">
								<h4 class="center">
									Have No Account ?
									<a href="#">
										Sign Up
									</a>
								</h4>
							</div>
						</div>
						<div class="col s12">
							<br>
							<div class="legal center">
							</div>
							<div class="legal center">
								<div class="col s12 m7 right">
									<p class="grey-text policy center">
										By signing up, you agree on our
										<a href="#!">
											Privacy Policy
										</a>
										and
										<a href="#!">
											Terms of Use
										</a>
										including
										<a href="#!">
											Cookie Use
										</a>
										.
									</p>
								</div>
								<div class="col s12 m5">
									<p class="center grey-text" style="font-size: 14px;">
										Coding :
										<a href="#" class="main-title red-text" target="_blank">
											@nkita
										</a>
									</p>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="fixed-action-btn toolbar">
					<a class="btn-floating btn-large amber black-text">
						Login
					</a>
					<ul>
						<li>
							<a class="indigo center" href="#!">
								Login with FB
							</a>
						</li>
						<li>
							<a class="blue center" href="#!">
								Login with Twitter
							</a>
						</li>
						<li>
							<a class="red center" href="#!">
								Login with Google +
							</a>
						</li>
					</ul>
				</div>
			</body>
		</html>
		<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
		<script src='https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.8/js/materialize.min.js'></script>
		<!-- <script src="View/JS/animate.js"></script> -->
		<script>
	jQuery(document).ready(function($){
	$(".dropdown-button").dropdown();
	$('.modal').modal();
	$(".signup-toggle").click(function(){
		$(this).hide();
		$(".signupForm").show(300);
		$(".policy").css("visibility","visible");
	});
	});
	</script>
	</body>
</html>
<!---Messages for the users--->
<cfif isDefined("url.success")>
	<cfif "#url.success#" EQ "true">
		<script>
			<cfoutput>
			document.getElementById("message").innerHTML="Thankyou, for successfully Joining us..";
			</cfoutput>
		</script>
	<cfelse>
		<script>
			<cfoutput>
			document.getElementById("message").innerHTML="Sorry,couldn't sign up.Please try again..";
			</cfoutput>
		</script>
	</cfif>
</cfif>
<cfif isDefined("url.logout")>
	<cfif url.logout EQ true>
		<script>
			<cfoutput>
			document.getElementById("message").innerHTML="Thanx for using Letz Chat!"
			</cfoutput>
		</script>
	<cfelse>
		<script>
			<cfoutput>
			document.getElementById("message").innerHTML="Sorry, couldn't logout successfully.."
			</cfoutput>
		</script>
	</cfif>
</cfif>
<cfif isDefined("url.login")>
	<cfif url.login EQ false>
		<script>
			<cfoutput>
			document.getElementById("message").innerHTML="Sorry,couldn't login because you have entered wrong username/password or someone in here is already logged in."
			</cfoutput>
		</script>
	</cfif>
</cfif>
<cfif isDefined("url.loginAgain")>
	<cfif url.loginAgain EQ "true">
		<script>
			<cfoutput>
			document.getElementById("message").innerHTML="Please Try to login again."
			</cfoutput>
		</script>
	</cfif>
</cfif>
