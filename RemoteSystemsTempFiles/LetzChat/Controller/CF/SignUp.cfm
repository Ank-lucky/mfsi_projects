<cfif  structKeyExists(form,"Register")>
	<!--Server Side Validation-->
	<cfset errorMessages = Arraynew(1) />
	<cfif form.FirstName EQ '' >
		<cfset arrayAppend(errorMessages,"*Please provide your firstname")/>
	</cfif>
	<cfif form.Lastname EQ '' >
		<cfset arrayAppend(errorMessages,"*Please provide your lastname")/>
	</cfif>
	<cfif form.UserName EQ '' >
		<cfset arrayAppend(errorMessages,"*Please provide an unique User Name ")/>
	</cfif>
	<cfif form.DOB EQ '' >
		<cfset arrayAppend(errorMessages,"*Please provide your date of birth")/>
	</cfif>
	<cfif form.Gender EQ '' >
		<cfset arrayAppend(errorMessages,"*Please provide your gender")/>
	</cfif>
	<cfif form.PhoneNo EQ '' >
		<cfset arrayAppend(errorMessages,"*Please provide your phone number")/>
	</cfif>
	<cfif form.Email EQ '' OR NOT isValid('eMail',form.Email) >
		<cfset arrayAppend(errorMessages,"*Please provide proper email-id")/>
	</cfif>
	<cfif arrayIsEmpty(errorMessages)>
		<!---function call to enter the data in db --->
		<cfset success= CreateObject("Component","local.Model.Components.SignUp").storeUserDetails('#form#')>
		<cfif success EQ "true">
			<cflocation url="../../index.cfm?success=true" addtoken="no"> <!---Return with a successful message--->
		<cfelse>
			<cflocation url="../../index.cfm?success=false" addtoken="no"> <!---Return with a failed message--->
		</cfif>
	</cfif>
	<cfif  isDefined("errorMessages") AND NOT ArrayisEmpty(errorMessages)>
			<cflocation url="../../index.cfm?success=false" addtoken="no"> <!---Return with a failed message--->
	</cfif>
</cfif>
