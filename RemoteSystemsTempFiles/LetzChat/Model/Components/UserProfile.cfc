<cfcomponent>

	<!---function to retrieve userDetails--->
	<cffunction name="retrieveUserDetails" access="remote" returnformat="json" returntype="struct" >
		<cfargument name="userId" type="string" required="yes" />
		<cfset var userDetail={} />
		<cfset var friendDetail={} />
		<cftry>
			<cfquery  name="collectUserDetails">
						SELECT acc.UserName,
							   acc.FirstName,
							   acc.MiddleName,
							   acc.LastName,
							   acc.PhoneNumber,
							   acc.EmailId,
							   acc.AddressId,
							   acc.Imagepath,
							   acc.DateOfBirth,
							   acc.Gender,
							   addr.Country,
							   addr.State,addr.City
						 FROM AccountDetails acc JOIN Address addr
						 ON  AccountId= <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_integer">
						 AND acc.AddressId=addr.AddressId
			</cfquery>

			<cfif collectUserDetails.recordcount EQ 1>
				<cfset userDetail={'UserName'=collectUserDetails.UserName,
									'FirstName'=collectUserDetails.FirstName,
									'MiddleName'=collectUserDetails.MiddleName,
									'LastName'=collectUserDetails.LastName,
									'PhoneNumber'=collectUserDetails.PhoneNumber,
									'EmailId'=collectUserDetails.EmailId,
									'Imagepath'=collectUserDetails.Imagepath,
									'DateOfBirth'=collectUserDetails.DateOfBirth,
									'Gender'=collectUserDetails.Gender,
									'Country'=collectUserDetails.Country,
									'State'=collectUserDetails.State,
									'City'=collectUserDetails.City,
									'isUserLoggedIn'="true"} />
			</cfif >
			<cfquery name="friends">
			 SELECT contct.FriendId,
						 		acct.UserName,
								acct.FirstName,
								acct.MiddleName,
								acct.LastName,
								acct.EmailId,
								acct.Imagepath
						FROM AccountDetails acct JOIN CONTACTS contct
						ON acct.AccountId=contct.FriendId
						AND contct.userId=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_integer">
			</cfquery>
			<!---Retrieve Friends details--->
			<cfif friends.recordcount GT 0 >
			<cfset end="#friends.recordcount#"+1/>
			<cfset ctr=1/>
			<cfloop query="friends" startRow=1 endRow="#end#" >
				<cfset friendProfile= {'UserName'=UserName,'EmailId'=EmailId,'Imagepath'=Imagepath,'FirstName'=FirstName,
										'MiddleName'=MiddleName,'LastName'=LastName} />
				<cfset structAppend(friendDetail,{"friends#ctr#"= #friendProfile#},true)/>
				<cfset ctr++/>

			</cfloop>
			<cfelse>
				<cfset structAppend(friendDetail,{"friends"="NULL"}) />
			</cfif>

			<cfcatch>
				<cfreturn  {}/>
			</cfcatch>
	 </cftry>
		<cfset structAppend(userDetail,{"friends"=#friendDetail#},true) />
		<cfreturn "#userDetail#" />
	</cffunction>

<!---Function to updateUserDetails--->
	<cffunction name="updateUserDetails" access="remote" returnformat="json" returntype="boolean">
		<cfargument name="userId" type="string" />
		<cfargument name="firstName" type="string" />
		<cfargument name="middleName" type="string"/>
		<cfargument name="lastName" type="string" />
		<cfargument name="emailId" type="string" />
		<cfargument name="country" type="string" />
		<cfargument name="state" type="string" />
		<cfargument name="city" type="string" />
		<cftry>
			<cfquery name="updateprofile">
				UPDATE AccountDetails
				SET 	FirstName=<cfqueryparam value="#arguments.firstName#" cfsqltype='cf_sql_varchar'>,
					    MiddleName=<cfqueryparam value="#arguments.middleName#" cfsqltype='cf_sql_varchar'>,
						LastName=<cfqueryparam value="#arguments.lastName#" cfsqltype='cf_sql_varchar'>,
						EmailId=<cfqueryparam value="#arguments.emailId#" cfsqltype='cf_sql_varchar'>
						WHERE AccountId=<cfqueryparam value="#arguments.userId#" cfsqltype='cf_sql_integer'>

				SELECT AddressId FROM AccountDetails WHERE AccountId=<cfqueryparam value="#arguments.userId#" cfsqltype='cf_sql_integer'>
			</cfquery>
			<cfquery>
				UPDATE Address
				SET Country= <cfqueryparam value="#arguments.country#" cfsqltype='cf_sql_varchar'>,
								   State=<cfqueryparam value="#arguments.state#" cfsqltype='cf_sql_varchar'>,
								   City=<cfqueryparam value="#arguments.city#" cfsqltype='cf_sql_varchar'>
				WHERE AddressId=<cfqueryparam value="#updateprofile.AddressId#" cfsqltype='cf_sql_integer'>
			</cfquery>
			<cfcatch>
				<cfreturn "false" />
			</cfcatch>
		</cftry>
		<cfreturn "true" />
	</cffunction>

<!---Function to search contact--->
	<cffunction name="searchToAddContact" access="remote" returformat="json" returntype="query">
		<cfargument name="userId" type="string">
		<cfargument name="keyWord" type="string">



	</cffunction>

	<!---Function to add Contact--->
	<!---<cffunction name="addAsContact" access="remote" returntype=> --->

</cfcomponent>
