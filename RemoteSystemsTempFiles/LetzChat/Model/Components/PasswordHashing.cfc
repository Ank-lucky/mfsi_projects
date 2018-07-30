<cfcomponent>
	<cffunction name="returnHashPassword" access="public" returntype="string">
		<cfargument name="password" type="string" required="true">
		<cfargument name="hashAlgorithm" type="string" required="true">
		<cfreturn HASH("#password#","#hashAlgorithm#")/>
	</cffunction>
</cfcomponent>