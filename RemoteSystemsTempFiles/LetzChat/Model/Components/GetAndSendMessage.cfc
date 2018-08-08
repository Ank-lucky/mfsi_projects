<cfcomponent displayname="GetAndSendMessage">
<cffunction name="sendMessage" access="remote" output="true" returntype="boolean">
	<cfargument name="chatId" type="string" required="yes" />
	<cfargument name="message" type="string" required="yes" />

	<cfset storeMessage=querynew("") />
	<cfset sentTime = CREATEODBCDATETIME( Now() ) />
	<cfset recieveTime = CREATEODBCDATETIME( Now() ) />

	<cftry>

		<cfquery name="storeMessage">
			INSERT INTO Messages (Message,ChatId,SentTime,RecieveTime,Online,Delivered)
			VALUES (<cfqueryparam value="#arguments.message#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#arguments.chatId#" cfsqltype="cf_sql_integer">,
					<cfqueryparam value="#sentTime#" cfsqltype="cf_sql_timestamp">,
					<cfqueryparam value="#recieveTime#" cfsqltype="cf_sql_timestamp">,1,0)
		</cfquery>

	<cfcatch>
		<cflog type="Error" file="sendMessage" text="Exception Error : Type=#cfcatch.type# Message=#cfcatch.message#">
		<cfreturn false />
	</cfcatch>
	</cftry>

	<cfreturn true />
</cffunction>

/*Retrive Messages*/
<cffunction name="getMessage" access="remote" returnformat="json" returntype="array">
	<cfargument name="userId" type="string" required="yes" />
	<cfargument name="friendId" type="string" required="yes" />
	<cfset var getMessageDetails=querynew("") />
	<cfset var msgs=[] />
	<cfset var eachMessage={} />
	<cftry>
		<cfquery name="getMessageDetails">
			SELECT ch.ChatId,ch.SenderId,ch.RecieverId,msg.Message,msg.RecieveTime,msg.SentTime
			FROM ChatRoom ch  JOIN Messages msg
  			ON (	ch.SenderId=<cfqueryparam value="#arguments.friendId#" cfsqltype="cf_sql_integer">
				AND ch.RecieverId=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_integer">
				OR  ch.SenderId=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_integer">
				AND ch.RecieverId=<cfqueryparam value="#arguments.friendId#" cfsqltype="cf_sql_integer"> )
				AND ch.ChatId= msg.ChatId ORDER BY msg.SentTime
		</cfquery>
		<!--- <cfquery name="getSenderAndRecieverName"> --->
<!--- 			SELECT sender.UserName,reciever.UserName --->
<!--- 			FROM AccountDetails sender JOIN AccountDetails reciever --->
<!--- 			WHERE sender.AccountId=getMessageDetails.SenderId AND reciever.AccountId=getMessageDetails.RecieverId --->
<!--- 		</cfquery> --->
		<cfloop query="getMessageDetails">
			<cfset eachMessage={"Message"=getMessageDetails.Message,
								"SentTime"=getMessageDetails.SentTime,
								"RecieveTime"=getMessageDetails.RecieveTime,
								"ChatId"=getMessageDetails.ChatId,
								"SenderId"=getMessageDetails.SenderId
								} >
			<cfset arrayAppend(msgs,eachMessage)>
		</cfloop>


	<cfcatch>
		<cflog type="Error" file="getMessage" text="Exception Error : Type=#cfcatch.type# Message=#cfcatch.message#">
	</cfcatch>
	</cftry>
	<cfreturn msgs />

</cffunction>
</cfcomponent>