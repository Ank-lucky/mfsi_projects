<cfcomponent>

	<!---Function to login--->
	<cffunction name="doLogin" access="public"  returntype="boolean" >
		<cfargument name="emailOrUsername" type="string" required="true"/>
		<cfargument name="passkey" type="string" required="true"/>
		<cfset lockSimultaneousUserLogin=createObject("component","LockSimultaneousLogin").LockMutualLogin("#arguments.emailOrUsername#","#arguments.passkey#")>

		<cftry>
			<cfif lockSimultaneousUserLogin EQ "true">
				<cfreturn "false"/>
			<cfelse>
				<!---If unique session id allow to login--->
				<cfset hashFormPasskey=createObject("component","PasswordHashing").returnHashPassword("#arguments.passkey#",'SHA1') />

					<cfquery name="updateSessionIdcollectUserDetails">

						UPDATE AccountDetails
							   SET SessionId = '#Session.sessionid#'
							   WHERE  EmailId=<cfqueryparam value="#arguments.EmailOrUserName#" cfsqltype="cf_sql_varchar"/>
							   OR UserName= <cfqueryparam value="#arguments.EmailOrUserName#" cfsqltype="cf_sql_varchar"/>
						SELECT AccountId,
							   UserName,ImagePath
							   PasswordHash
							   FROM AccountDetails
							   WHERE EmailId=<cfqueryparam value="#arguments.emailOrUserName#" cfsqltype="cf_sql_varchar"/>
							   OR UserName= <cfqueryparam value="#arguments.emailOrUserName#" cfsqltype="cf_sql_varchar"/>
							   AND PasswordHash= <cfqueryparam value="#hashFormPasskey#" cfsqltype="cf_sql_varchar"/>
							   AND IsUserActive = 1

					</cfquery>

					<cfif updateSessionIdcollectUserDetails.recordCount EQ 1  >
						<cflogin>
							<cfloginuser name="#updateSessionIdcollectUserDetails.UserName#" password="#updateSessionIdcollectUserDetails.PasswordHash#" roles="user">
						</cflogin>
						<cfset Session.loggedInUser={'userName'=updateSessionIdcollectUserDetails.UserName,'isUserLoggedIn'=true,'userId'=updateSessionIdcollectUserDetails.AccountId}/>
					<cfelse>
						<cfreturn false />
					</cfif>
			</cfif>
		<cfcatch type="database">
					<cfset message=cfcatch.cause.message />
					<cflog type="Error" file="doLogin" text="Exception error Exception message:#message#" />
					<cfreturn false />
		</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

<!---Function to logout--->
<cffunction name="logout" output="false" returntype="boolean">

		<cftry>
			<cfquery>
					UPDATE AccountDetails
					SET SessionId=NULL
					WHERE AccountId=<cfqueryparam value="#Session.loggedInUser.userId#" cfsqltype="cf_sql_integer"/>
			</cfquery>
			<!--- <cfset structDelete(session,'sessionId') /> --->
			<cfset structClear(session)>
			<cfset structDelete(cookie, 'CFID')/>
			<cfset structDelete(cookie, 'CFToken') />
			<cflogout/>
		<cfcatch type="any">
			<cfset message=cfcatch.cause.message />
			<cflog type="Error" file="logout" text="Exception error Exception type:#cfcatch.type# message:#message#" />
			<cfreturn false />
		</cfcatch>
		</cftry>
			<cfreturn true />
	</cffunction>

</cfcomponent>
