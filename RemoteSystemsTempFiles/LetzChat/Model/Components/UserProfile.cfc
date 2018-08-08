<cfcomponent>

	<!---function to retrieve userDetails--->
	<cffunction name="retrieveUserDetails" access="remote" returnformat="json" returntype="struct" >
		<cfargument name="userId" type="string" required="yes" />
		<cfset var userDetail={} />
		<cfset var friendDetail={} />
		<cfset var collectUserDetails=querynew("")>
		<cfset var friendsDetails=querynew("")>

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
									'IsUserLoggedIn'="true"} />
			</cfif >
			<cfquery name="friendsDetails">
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
			<cfif friendsDetails.recordcount GT 0 >

				<cfset ctr=1/>
				<cfloop query="friendsDetails">
					<cfset friendProfile= {'FriendId'=friendsDetails.FriendId,
										   'UserName'=friendsDetails.UserName,
										   'EmailId'=friendsDetails.EmailId,
										   'Imagepath'=friendsDetails.Imagepath,
										   'FirstName'=friendsDetails.FirstName,
										   'MiddleName'=friendsDetails.MiddleName,
										   'LastName'=friendsDetails.LastName} />
					<cfset structAppend(friendDetail,{"friends#ctr#"= friendProfile},true)/>
					<cfset ctr++/>
				</cfloop>
			<cfelse>
				<cfset structAppend(friendDetail,{"friends"="NULL"}) />
			</cfif>

	  <cfcatch type="any">
		 <cfset  type=cfcatch.type />
				<cfset message=cfcatch.cause.message />
				<cflog type="Error" file="retrieveUserDetails" text="Exception error Exception type: #type# message:#message#" />
				<cfreturn  {}/>
	  </cfcatch>
	 </cftry>
		<cfset structAppend(userDetail,{"friends"=friendDetail},true) />
		<cfreturn userDetail />
	</cffunction>

<!---Function to updateUserDetails--->
	<cffunction name="updateUserDetails" access="remote"  returntype="boolean">
		<cfargument name="userId" type="string" />
		<cfargument name="firstName" type="string" />
		<cfargument name="middleName" type="string"/>
		<cfargument name="lastName" type="string" />
		<cfargument name="country" type="string" />
		<cfargument name="state" type="string" />
		<cfargument name="city" type="string" />

		<cfset var updateprofile=querynew("")>
		<cftry>
			<cftransaction>
			<cfquery name="updateprofile">
				UPDATE AccountDetails
				SET 	FirstName=<cfqueryparam value="#arguments.firstName#" cfsqltype='cf_sql_varchar'>,
					    MiddleName=<cfqueryparam value="#arguments.middleName#" cfsqltype='cf_sql_varchar'>,
						LastName=<cfqueryparam value="#arguments.lastName#" cfsqltype='cf_sql_varchar'>
						WHERE AccountId=<cfqueryparam value="#arguments.userId#" cfsqltype='cf_sql_integer'>
			</cfquery>
			<cfquery name="addr">
				UPDATE Address
				SET Country= <cfqueryparam value="#arguments.country#" cfsqltype='cf_sql_varchar'>,
								   State=<cfqueryparam value="#arguments.state#" cfsqltype='cf_sql_varchar'>,
								   City=<cfqueryparam value="#arguments.city#" cfsqltype='cf_sql_varchar'>
				WHERE AddressId=(SELECT AddressId FROM AccountDetails WHERE AccountId=<cfqueryparam value="#arguments.userId#" cfsqltype='cf_sql_integer'>)
			</cfquery>
			</cftransaction>
		<cfcatch type="any">
				<cfset  type=cfcatch.type />
				<cfset message=cfcatch.message />
				<cflog type="Error" file="updateUserDetails" text="Exception error Exception type: #type# message:#message#" />
				<cfreturn false />
		</cfcatch>
		</cftry>

		<cfreturn true />
	</cffunction>

<!---Upload profile Pic--->
<cffunction name="uploadProfilePic" access="remote"  returntype="boolean">
	<cfargument name="image" type="string" required="yes" />
	<cfargument name="userId" type="string" required="yes" />
	<cfset var getImage=queryNew("") />
	<cftry>
		<cfquery>
			UPDATE AccountDetails SET ImagePath=<cfqueryparam value="#arguments.image#" cfsqltype="cf_sql_varchar" />
			WHERE AccountId = <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfquery name="getImage">
			SELECT ImagePath FROM AccountDetails WHERE AccountId=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfset structAppend(session.loggedInUser,{'image'='getImage.ImagePath'})>
	<cfcatch>
		<cflog type="Error" file="uploadProfilePic" text="Exception error Exception type: #type# message:#message#" />
		<cfreturn false />
	</cfcatch>
	</cftry>
		<cfreturn true />

</cffunction>


<!---Function to search contact--->
	<cffunction name="searchToAddContact" access="remote">
		<cfargument name="userId" type="string">
		<cfargument name="keyWord" type="string">

		<cfset var contactList=querynew("") />

		<cftry>
			<cfquery name="contactList">
				 SELECT acc.AccountId,acc.UserName,acc.EmailId,acc.ImagePath
				 FROM AccountDetails acc
				 WHERE acc.AccountId
				 NOT IN (SELECT contct.FriendId from AccountDetails acct JOIN CONTACTS contct
						 ON contct.UserId =  <cfqueryparam value="#arguments.userId#" cfsqltype='cf_sql_integer'>
						 AND acct.AccountId=contct.FriendId)
				 AND AccountId != <cfqueryparam value="#arguments.userId#" cfsqltype='cf_sql_integer'>
				 AND (UserName LIKE  <cfqueryparam value="%#arguments.keyWord#%" cfsqltype='cf_sql_varchar'>
				 OR EmailId LIKE <cfqueryparam value="%#arguments.keyWord#%" cfsqltype='cf_sql_varchar'>)
			</cfquery>

		<cfcatch type="any">
				<cfset  type=cfcatch.Type />
				<cfset message=cfcatch.cause.message />
				<cflog type="Error" file="searchToAddContact" text="Exception error Exception type: #type# message:#message#" />
		</cfcatch>
		</cftry>
		<cfoutput>
			#serializeJSON(contactList)#
		</cfoutput>

	</cffunction>

<!---Function to add Contact--->
<cffunction name="addContact" access="remote" returntype="boolean">
		<cfargument name="userId" type="string">
		<cfargument name="friendId" type="string">

		<cftry>
			<cfquery>
				INSERT INTO CONTACTS (UserId,FriendId)
				VALUES (<cfqueryparam value="#arguments.userId#" cfsqltype='cf_sql_integer'>,
						<cfqueryparam value="#arguments.friendId#" cfsqltype='cf_sql_integer'>)
			</cfquery>
		<cfcatch>
			<cfset  type=cfcatch.Type />
				<cfset message=cfcatch.cause.message />
				<cflog type="Error" file="addContact" text="Exception error Exception type: #type# message:#message#" />
				<cfreturn false />
		</cfcatch>

		</cftry>
			<cfreturn true />
</cffunction>

<!---Function to create if ChatRoom is not created and open ChatRoom  --->
<cffunction name="openChatRoom" access="remote">
	<cfargument name="userId" type="string" required="yes">
	<cfargument name="friendId" type="string">
	<cfargument name="groupId" type="string">


	<cfset getChatId=querynew("")>
	<cfset oneReciever=(arguments.friendId NEQ "NULL") && (arguments.groupId EQ "NULL")>
	<cfset groupReciever=(arguments.friendId EQ "NULL") && (arguments.groupId NEQ "NULL")>
		<cftry>
		<!---If either friendId or groupId is null--->
		<cfif oneReciever || groupReciever >
			<!---If not a group chat room--->
			<cfif arguments.friendId NEQ "NULL">
				<cfquery name="getChatId">
					SELECT ChatId FROM ChatRoom
					WHERE SenderId =<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_integer">
					AND RecieverId=<cfqueryparam value="#arguments.friendId#" cfsqltype="cf_sql_integer">

				</cfquery>
				<cfif getChatId.recordcount EQ 0>
					<cfquery>
						INSERT INTO ChatRoom (SenderId,RecieverId)
						VALUES (<cfqueryparam  value="#arguments.userId#" cfsqltype="cf_sql_integer">,
								<cfqueryparam value="#arguments.friendId#" cfsqltype="cf_sql_integer">)
					</cfquery>
				</cfif>
					<cfquery name="getChatIdAndRecieverDetails">
						SELECT cr.ChatId,cr.RecieverId,acc.UserName,acc.ImagePath
						FROM ChatRoom cr JOIN AccountDetails acc
						ON (SenderId =<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_integer">
						AND RecieverId=<cfqueryparam value="#arguments.friendId#" cfsqltype="cf_sql_integer">
						AND acc.AccountId = <cfqueryparam value="#arguments.friendId#" cfsqltype="cf_sql_integer">)

					</cfquery>

			</cfif>
		</cfif>
		<cfcatch type="any">
			<cfset var type=cfcatch.type>
			<cfset var message=cfcatch.message>
			<cflog type="Error" file="openChatRoom" text="Exception error Exception type: #type# message:#message#">
		</cfcatch>
		</cftry>
		<cfoutput>
			#serializeJSON(getChatIdAndRecieverDetails)#
		</cfoutput>


</cffunction>

</cfcomponent>
