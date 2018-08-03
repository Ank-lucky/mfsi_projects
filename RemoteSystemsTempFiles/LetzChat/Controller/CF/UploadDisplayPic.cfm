<!--- <cfif structKeyExists(form,'uploadPicform')> --->
<!--- 	<cfdump var="#form#"> --->

<!--- 	<cfdump var="#Session.loggedInUser.userId#"> --->

<!--- 		<cfif isDefined("form.profilePic") AND len(form.profilePic) > --->
<!--- 			<cfset var fileName ="#Session.loggedInUser.userName#"+"_"+"#Session.loggedInUser.userId#"> --->
<!--- 			<cfdump var="#fileName#" /> --->
<!--- 			<!--- <cfset var destination=> ---> --->
<!--- <!--- 			<cffile action="upload" filefield="productImage" destination="#destination#" nameconflict="makeunique" result="upload_result" accept="image/*"> ---> --->
<!--- <!--- 			<cfset result = application.products.addPicture(#fileName#)/> ---> --->
<!--- 		</cfif> --->
<!--- </cfif> --->