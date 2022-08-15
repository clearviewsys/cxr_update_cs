//%attributes = {}


// validateTable (->table) : boolean 
// returns a boolean about validation

C_POINTER:C301($1)
C_BOOLEAN:C305($0)
C_TEXT:C284($tMethodName)

checkInit

If ($1=(->[Customers:3])) & ([Customers:3]approvalStatus:146>=2)  //`start with not approved
	//don't run validation it will fail sumbit newprofile and leave onHold
Else 
	
	$tMethodName:="validate"+Table name:C256($1)
	
	If (UTIL_isMethodExists($tMethodName))
		EXECUTE METHOD:C1007($tMethodName)
	End if 
	
	
	//checkFieldConstraintsForTable ($1;False)  // check all the field constraints for table (non conditional ones)
	//this fails b/c if you make mandatory baank acct number but do not check isTranferToBank this will fail and it shouldn't
	// and this is actually done in WAPI_onSubmitRecord prior to saving
End if 

$0:=webIsValidationConfirmed
