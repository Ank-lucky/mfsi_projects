
<cfif structKeyExists(form,'uploadPicform') && structKeyExists(session,'loggedInUser') >

			<cfset fileName=session.loggedInUser.userName&"_"&session.loggedInUser.userId/>
			<cfset destination = ExpandPath( "../../View/images/uploadPic/#fileName#.jpg" ) />
		 	<cffile action="upload" filefield="profilePic" destination="#destination#" nameconflict="overwrite" result="upload_result" accept="image/*">
			<cfset imageName=upload_result.serverFileName>
			<cfset upload=createObject("component","local.Model.Components.UserProfile").uploadProfilePic(imageName,session.loggedInUser.userId) />
			<cfif upload EQ true>
				<cflocation url="../../View/HTML/chatPage.cfm?uploadedPicSuccessfully=true" addtoken="no" />
			<cfelse>
				<cflocation url="../../View/HTML/chatPage.cfm?uploadedPicSuccessfully=false" addtoken="no" />
			</cfif>
<cfelse>
			<cflocation url="../../View/HTML/chatPage.cfm" />
</cfif>