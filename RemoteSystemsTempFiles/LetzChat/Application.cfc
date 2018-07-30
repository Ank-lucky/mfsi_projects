<cfcomponent>

	<cfset this.name="LetzChatzzzWebApp"/>
	<cfset this.applicationTimeout= createTimespan(0,2,0,0)/>
	<cfset this.datasource="chatDb" />
	<cfset this.sessionmanagement="yes" />
	<cfset this.mappings["/local"] = getDirectoryFromPath(getCurrentTemplatePath()) />

	<cffunction name="onSessionStart" acess="public" returnType="void" output="false">

		<cfreturn />
	</cffunction>


	<cffunction name="OnRequestStart" access="public" returntype="boolean" output="true">
		<cfreturn true/>
	</cffunction>


</cfcomponent>
