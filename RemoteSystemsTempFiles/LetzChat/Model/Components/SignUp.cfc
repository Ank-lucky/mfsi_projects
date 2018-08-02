<cfcomponent>


	<cffunction name="storeUserDetails" access="public" returnType="boolean">
		<cfargument name="form" type="struct" required="true">
		<cfset form.IsUserActive=1/>
		<cfset form.ImagePath = expandPath('../../View/images/avatar-default-icon.png') />
		<cfset Passkey=createObject("component","PasswordHashing").returnHashPassword("#form.Password#",'SHA1') />

		<cftry>
			<!---Query for storing address details  --->
			<cfquery result="result" >
	  			insert into Address(City,State,Country)
	     			values(<cfqueryparam value='#form.City#' cfsqltype="cf_sql_varchar">,
	     					<cfqueryparam value='#form.State#' cfsqltype="cf_sql_varchar">,
	     					<cfqueryparam value='#form.Country#' cfsqltype="cf_sql_varchar">)
	  		</cfquery>
			<cfset datatime = CREATEODBCDATETIME( Now() ) />
			<!---Query for storing User Details  --->
			<cfquery>
		 	insert into AccountDetails
	 			(UserName,FirstName,MiddleName,LastName,IsUserActive,PasswordHash,PhoneNumber,EmailId,AddressId,ImagePath,DateofBirth,Gender,AccountCreationDate)
	   				values(
	   				<cfqueryparam value='#form.UserName#' cfsqltype="cf_sql_varchar">,
	   				<cfqueryparam value='#form.FirstName#' cfsqltype="cf_sql_varchar">,
	   				<cfqueryparam value='#form.MiddleName#' cfsqltype="cf_sql_varchar">,
	   				<cfqueryparam value='#form.LastName#' cfsqltype="cf_sql_varchar">,
	      			<cfqueryparam value='#form.IsUserActive#' cfsqltype="cf_sql_bit">,
	      			<cfqueryparam value='#Passkey#' cfsqltype="cf_sql_varchar">,
	      			<cfqueryparam value='#form.PhoneNo#' cfsqltype="cf_sql_varchar">,
	      			<cfqueryparam value='#form.Email#' cfsqltype="cf_sql_varchar">,
	      			<cfqueryparam value='#result.generatedKey#' cfsqltype="cf_sql_integer">,
					<cfqueryparam value='#form.ImagePath#' cfsqltype="cf_sql_varchar">,
					<cfqueryparam value='#form.DOB#' cfsqltype="cf_sql_date">,
					<cfqueryparam value='#form.Gender#' cfsqltype="cf_sql_varchar">,
				 	<cfqueryparam value="#datatime#" cfsqltype="cf_sql_timestamp">)
	 		</cfquery>
			<cfcatch type="any">
				<cfset message=cfcatch.cause.message />
				<cflog type="Error" file="storeUserDetails" text="Exception error Exception type:#cfcatch.type# message:#message#" />
				<cfreturn "false"/>
			</cfcatch>
		</cftry>
		<cfreturn "true"/>
	</cffunction>


</cfcomponent>
