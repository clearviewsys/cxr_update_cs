//%attributes = {}
// this is part of KYC validation 
// PRE: Customer must be loaded

C_BOOLEAN:C305(<>doCheckCustomerProfile)
C_BOOLEAN:C305($inReview; $1)

Case of 
	: (Count parameters:C259=0)
		$inReview:=False:C215
	: (Count parameters:C259=1)
		$inReview:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (<>doCheckCustomerProfile)  // FINTRAC compliancy checks
	If (Not:C34([Customers:3]isCompany:41))  // checks to be performed for non companies
		validateCustomerKYC($inReview)
	Else 
		validateCompanyKYC($inReview)
	End if 
End if 

checkAddErrorIf(([Customers:3]AML_isPEP:80=1) & ([Customers:3]AML_PEPNotes:133=""); "Please enter basis for PEP determination!")
checkAddErrorIf(([Customers:3]AML_isHIO:124=1) & ([Customers:3]AML_HIONotes:134=""); "Please enter basis for HIO determination!")

// TODO move to IM_preformKYCRelatedTasks, because it is easier for me to have everything in one place. - Wai-Kin
If (getKeyValue("identityMind.activated"; "False")="True")
	If ((getKeyValue("identityMind.autoCheckOnSave"; "False")="True"))
		If (Is new record:C668([Customers:3]))  // | Modified record([Customers]))
			//C_TEXT($state)
			//C_TEXT($answer)
			//$answer:=IM_preformKYCRelatedTasks ("autoCheck")
			//$state:=IM_showKYCValue ($answer;"state")
			//If ($state#"A")
			//C_TEXT($frn)
			//$frn:=IM_showKYCValue ($answer;"frn")
			//checkAddWarning ("IdentityMind match:"+$frn)
			//End if 
		End if 
	End if 
End if 