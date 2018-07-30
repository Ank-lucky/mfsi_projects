<!---Login User--->
<cfif structKeyExists(form,'Login')>
	<cfset loginService=createObject("component","local/Model/Components/Login") >
	<cfset UserDetails= loginService.doLogin(form.EmailOrUserName,form.Password)>
	<cfif structIsEmpty(UserDetails) EQ "false">
		<cflocation url="../../View/HTML/chatPage.cfm?profile=#UserDetails.userId#" addtoken="no"/>
	<cfelse>
		<cflocation url="../../index.cfm?login=false" addtoken="no">
	</cfif>
</cfif>

<!---Logout User--->
<cfif isDefined("url.logout")>
	<cfset loginService=createObject("component","local/Model/Components/Login") >
	<cfset success=loginService.logout("#url.logout#")/>
	<cfif success EQ "true">
		<cflocation url="../../index.cfm?logout=true" addtoken="no">
	<cfelse>
		<cflocation url="../../index.cfm?logout=false" addtoken="no">
	</cfif>
</cfif>
