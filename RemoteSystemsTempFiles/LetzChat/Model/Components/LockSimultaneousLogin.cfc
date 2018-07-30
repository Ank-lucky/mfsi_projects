<cfcomponent>

	<!---Lock if is of same session id--->

	<cffunction name="LockMutualLogin" access="public" returntype="boolean">
		<cfargument name="emailOrUsername" type="string" required="true"/>
		<cfargument name="passkey" type="string" required="true"/>
		<cflock timeout=20 scope="Session" type="Readonly">
			<cfquery name="sessionsCount">

							Select AccountId from AccountDetails where SessionId= '#Session.sessionid#'

			</cfquery>
			<cfif sessionsCount.recordcount NEQ 0>
				<cfquery name="checkIfSameUserLoggined">
							Select AccountId from AccountDetails where EmailId=<cfqueryparam value="#arguments.emailOrUserName#" cfsqltype="cf_sql_varchar"/>
												OR UserName= <cfqueryparam value="#arguments.emailOrUserName#" cfsqltype="cf_sql_varchar"/>
							</cfquery>
				<cfif sessionsCount.AccountId NEQ checkIfSameUserLoggined.AccountId >
					<cfreturn "true" />
				</cfif>
			</cfif>
		</cflock>
		<cfreturn "false" />
	</cffunction>


</cfcomponent>
