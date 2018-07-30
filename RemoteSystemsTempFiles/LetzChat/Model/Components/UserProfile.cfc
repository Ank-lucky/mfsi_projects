<cfcomponent>

	<!---function to retrieve userDetails--->

	<cffunction name="retrieveUserDetails" access="remote" returnformat="json" returntype="struct" >
		<cfargument name="userId" type="string" required="yes" />
		<cfset var userDetail={} />
		<cfset var friendDetail={} />
		<cftry>
			<cfquery  name="collectUserDetails">
						SELECT UserName,FirstName,MiddleName,LastName,PhoneNumber,EmailId,AddressId,Imagepath,DateOfBirth,Gender
						 FROM AccountDetails WHERE  AccountId= <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_integer">
					</cfquery>
			<cfquery name="addressDetails">
					SELECT Country,State,City FROM Address WHERE AddressId = <cfqueryparam value="#collectUserDetails.AddressId#" cfsqltype="cf_sql_integer">
					</cfquery>
			<cfquery  name="friends">
						SELECT FriendId FROM CONTACTS WHERE UserId=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_integer">
					</cfquery>
			<cfif collectUserDetails.recordcount EQ 1>
				<cfset userDetail={'UserName'=collectUserDetails.UserName,'FirstName'=collectUserDetails.FirstName,'MiddleName'=collectUserDetails.MiddleName,
					'LastName'=collectUserDetails.LastName,'PhoneNumber'=collectUserDetails.PhoneNumber,'EmailId'=collectUserDetails.EmailId,
					'Imagepath'=collectUserDetails.Imagepath,'DateOfBirth'=collectUserDetails.DateOfBirth,'Gender'=collectUserDetails.Gender,
					'Country'=addressDetails.Country,'State'=addressDetails.State,'City'=addressDetails.City,'isUserLoggedIn'="true"} />
			</cfif >
			<!---Retrieve Friends details--->
			<cfif friends.recordcount GT 0>
				<cfset end="#friends.recordcount#">
				<cfset end= "#(end+1)#">
				<cfset friend={}>
				<cfset ctr=1/>
				<cfloop  query="friends" startRow=1 endRow="#end#">
					<cfquery name="getFriendDetails">
								SELECT UserName,EmailId,AddressId,Imagepath,DateOfBirth,Gender
						 		FROM AccountDetails WHERE  AccountId= <cfqueryparam value="#friends.FriendId#" cfsqltype="cf_sql_integer">
						 		</cfquery>
					<cfquery name="friendAddressDetails">
							 		 SELECT Country,State,City FROM Address WHERE AddressId = <cfqueryparam value="#getFriendDetails.AddressId#" cfsqltype="cf_sql_integer">
							 	</cfquery>
					<cfset friendProfile= {'UserName'=getFriendDetails.UserName,'EmailId'=getFriendDetails.EmailId,'Imagepath'=getFriendDetails.Imagepath,
						'DateOfBirth'=getFriendDetails.DateOfBirth,'Gender'=getFriendDetails.Gender,'Country'=friendAddressDetails.Country,
						'State'=friendAddressDetails.State, 'City'=friendAddressDetails.City} />
					<cfset structAppend(friend,{"friend#ctr#" = #friendProfile#},true)/>
					<cfset ctr++/>
				</cfloop>
				<cfset structAppend(friendDetail,{"friends"= #friend#},true)/>
				<cfset structAppend(userDetail,friendDetail,true) />
			<cfelse>
				<cfset friendDetail={"friends"="NULL"}/>
				<cfset structAppend(userDetail,{"friends"="NULL"},true) />
			</cfif>
			<cfcatch>
				<cfoutput>
					Sorry, a database error has occurred. Please try again.
				</cfoutput>
				<cfreturn  {}/>
			</cfcatch>
		</cftry>
		<cfreturn "#userDetail#" />
	</cffunction>

	<!---Function to updateUserDetails--->

	<cffunction name="updateUserDetails" access="remote" returntype="boolean">
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
			UPDATE AccountDetails SET 	FirstName=<cfqueryparam value="#arguments.firstName#" cfsqltype='cf_sql_varchar'>,
										MiddleName=<cfqueryparam value="#arguments.middleName#" cfsqltype='cf_sql_varchar'>
										LastName=<cfqueryparam value="#arguments.lastName#" cfsqltype='cf_sql_varchar'>
										EmailId=<cfqueryparam value="#arguments.emailId#" cfsqltype='cf_sql_varchar'>
										  WHERE AccountId=<cfqueryparam value="#arguments.userId#" cfsqltype='cf_sql_integer'>
			SELECT AddressId FROM AccountDetails WHERE AccountId=<cfqueryparam value="#arguments.userId#" cfsqltype='cf_sql_integer'>
		</cfquery>
			<cfquery>
			UPDATE Address SET Country= <cfqueryparam value="#arguments.country#" cfsqltype='cf_sql_varchar'>,
									State=<cfqueryparam value="#arguments.State#" cfsqltype='cf_sql_varchar'>,
									City=<cfqueryparam value="#arguments.State#" cfsqltype='cf_sql_varchar'>
							WHERE AddressId=<cfqueryparam value="#updateprofile.AddressId#" cfsqltype='cf_sql_integer'>
		</cfquery>
			<cfcatch>
				<cfreturn "false" />
			</cfcatch>
		</cftry>
		<cfreturn "true" />
	</cffunction>

	<!---Function to search contact--->

	<cffunction name="searchToAddContact" access="remote" returformat="json" returntype="struct">
		<cfargument name="userId" type="string">
		<cfset addContactsDetails={} />
		<cfset friends=arrayNew(1) />
		<!--- <cftry> --->
		<cfquery name="alreadyInContact">
			SELECT c.UserId,c.FriendId FROM AccountDetails a INNER JOIN CONTACTS c ON a.AccountId =c.UserId
			 AND a.AccountId=<cfqueryparam value="#arguments.userId#" cfsqltype='cf_sql_integer'>
		</cfquery>
		<cfset end="#alreadyInContact.recordcount#"+1/>
		<cfloop query="alreadyInContact" startRow=1 endRow="#end#" >
			<cfset arrayAppend(friends,#alreadyInContact.FriendId#) />
		</cfloop>
		<!---loop to get each people's details--->
		<!--- <cfquery name="peopleDetails"> --->
		<!--- 					SELECT AccountId,UserName,EmailId,FirstName,MiddleName,LastName,ImagePath,DateOfBirth,Gender,AddressId --->
		<!--- 					FROM AccountDetails WHERE NOT IN --->
		<!--- 					<cfloop array="#friends#" item="peopleList" index="i"> --->
		<!--- 					<cfqueryparam value="#peopleList#" cfsqltype="cf_sql_integer"> --->
		<!--- 					</cfloop> --->
		<!--- 		</cfquery> --->
		<!--- 				<cfset peopleCount="#peopleDetails.recordcount#"+1 /> --->
		<!--- 		<!---loop to store the details in a struction addContactDetails--->
		--->
		<!--- 		<cfloop query="peopleDetails" startRow=1 endRow="#peopleCount#" > --->
		<!--- 					<cfset peopleProfile= {'UserName'=UserName,'EmailId'=EmailId,'Imagepath'=Imagepath, --->
		<!--- 								'DateOfBirth'=DateOfBirth,'Gender'=Gender} /> --->
		<!--- 					<cfset structAppend(addContactsDetails,{"addContact#startRow#"="#peopleProfile#"},true) /> --->
		<!--- 				</cfloop> --->
		<!--- 				<cfcatch> --->
		<!--- 					<cfreturn {"failed"="Failed To Search Contacts To Be Added"} /> --->
		<!--- 				</cfcatch> --->
		<!--- 				</cftry> --->
		<cfreturn "#addContactsDetails#" />
	</cffunction>

	<!---Function to add Contact--->
	<!---<cffunction name="addAsContact" access="remote" returntype=> --->

</cfcomponent>
