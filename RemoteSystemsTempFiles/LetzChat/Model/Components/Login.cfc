<cfcomponent>

	<!---Function to login--->
	<cffunction name="doLogin" access="public" output="false" returntype="struct" >
		<cfargument name="emailOrUsername" type="string" required="true"/>
		<cfargument name="passkey" type="string" required="true"/>
		<cfset lockSimultaneousUserLogin=createObject("component","LockSimultaneousLogin").LockMutualLogin("#arguments.emailOrUsername#","#arguments.passkey#")>
		<cfif lockSimultaneousUserLogin EQ "true">
			<cfreturn {}/>
		<cfelse>
			<!---If unique session id allow to login--->
			<cfset hashFormPasskey=createObject("component","PasswordHashing").returnHashPassword("#arguments.passkey#",'SHA1') />
			<cftry>
				<cfquery name="updateSessionIdcollectUserDetails">

					UPDATE AccountDetails SET SessionId = '#Session.sessionid#' WHERE  EmailId=<cfqueryparam value="#arguments.EmailOrUserName#" cfsqltype="cf_sql_varchar"/>
															OR UserName= <cfqueryparam value="#arguments.EmailOrUserName#" cfsqltype="cf_sql_varchar"/>
					SELECT AccountId,UserName,PasswordHash,AddressId FROM AccountDetails WHERE
												  		EmailId=<cfqueryparam value="#arguments.emailOrUserName#" cfsqltype="cf_sql_varchar"/>
														OR UserName= <cfqueryparam value="#arguments.emailOrUserName#" cfsqltype="cf_sql_varchar"/>
														AND PasswordHash= <cfqueryparam value="#hashFormPasskey#" cfsqltype="cf_sql_varchar"/>
														AND IsUserActive = 1
				</cfquery>
				<cfquery name="collectAddressDetails" >
					SELECT Country,State,City FROM Address WHERE AddressId =<cfqueryparam value="#updateSessionIdcollectUserDetails.AddressId#">
				</cfquery>

				<cfif updateSessionIdcollectUserDetails.recordCount EQ 1  >
					<cflogin>
						<cfloginuser name="#updateSessionIdcollectUserDetails.UserName#" password="#updateSessionIdcollectUserDetails.PasswordHash#" roles="user">
					</cflogin>
					<cfset UserDetails={'userName'=updateSessionIdcollectUserDetails.UserName,'isUserLoggedIn'="true",'userId'=updateSessionIdcollectUserDetails.AccountId}/>
				<cfelse>
					<cfreturn {} />
				</cfif>
				<cfcatch type="database">
					<cfreturn {} />
				</cfcatch>
			</cftry>
		</cfif>
		<cfreturn "#UserDetails#" />
	</cffunction>

<!---Function to logout--->
<cffunction name="logout" output="false" returntype="boolean">
		<cfargument name="accountId" type="string" required="yes">
		<cftry>
		<cfquery>
				UPDATE AccountDetails  SET SessionId=NULL WHERE AccountId=<cfqueryparam value="#arguments.accountId#" cfsqltype="cf_sql_integer"/>
		</cfquery>
		<!--- <cfset structDelete(session,'sessionId') /> --->
		<cfset structClear(session)>
		<cfset structDelete(cookie, 'CFID')/>
		<cfset structDelete(cookie, 'CFToken') />
		<cflogout/>
		<cfcatch>
			<cfoutput>
			<p>Sorry,There's an error in database please refresh and try logging out again'</p>
			</cfoutput>
			<cfreturn "false" />
		</cfcatch>
		</cftry>
			<cfreturn "true" />
	</cffunction>

</cfcomponent>
