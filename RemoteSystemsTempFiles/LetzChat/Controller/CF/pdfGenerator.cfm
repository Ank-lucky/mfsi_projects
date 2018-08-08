<!Conversation---Generates pdf of the conv--->
<cfif structKeyExists(session,"loggedInUser") && structKeyExists(url,"selectedFriendId")>
<cfset getMsgs=createObject("component","local.Model.Components.GetAndSendMessage") />
<cfset method=getMsgs.getMessage(#session.loggedInUser.userId#,#url.selectedFriendId#) />
<html>
<head>
	<title>Pdf</title>
</head>
<body>
<cfdocument format="PDF">
<table>
<th>Message</th>
<th>SentTime</th>
<th>Recieve Time</th>
<cfloop  from="1" to="#Arraylen(method)#" index="i">

	<cfoutput>
		<tr style="border-top:1px solid black">
		<td style="border-right:1px solid black;border-left:1px solid black;border-top:1px solid black;;padding:5px 2px 5px 2px">#method[i].Message#</td>
		<td style="border-right:1px solid black;border-top:1px solid black;padding:5px 2px 5px 2px">#method[i].SentTime#</td>
		<td style="border-right:1px solid black;border-top:1px solid black;;padding:5px 2px 5px 2px">#method[i].RecieveTime#</td>
		</tr >
	</cfoutput>
</cfloop>

</table>

</cfdocument>
</body>
</html>

</cfif>

