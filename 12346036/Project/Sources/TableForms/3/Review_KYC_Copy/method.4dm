HandleEntryForm(Current form table:C627; ->[Customers:3]CreatedByUserID:58; ->[Customers:3]ModifiedByUserID:59; ->[Customers:3]BranchID:86; ->[Customers:3]modBranchID:111)

C_LONGINT:C283(cbCompanyOK; cbContactOK; cbAddressOK; cbPictureIDOK)
C_BOOLEAN:C305($cond1; $cond2)
$cond1:=(cbCompanyOK=1) & (cbContactOK=1) & (cbAddressOK=1)
$cond2:=$cond1 & (cbPictureIDOK=1)

setVisibleIff($cond1; "bConfirmContactInfo")
setVisibleIff($cond2; "bSaveAndConfirm@")
setVisibleIff(cbCompanyOK=0; "rectContactInfo")
setVisibleIff(cbContactOK=0; "rectAddress")


If (Form event code:C388=On Load:K2:1)
	cbCompanyOK:=0
	cbContactOK:=0
	cbAddressOK:=0
	cbPictureIDOK:=0
	cbProfileChecked:=0
	highlightMissingFieldsInCustKYC
	
	If ([Customers:3]DOB:5=!00-00-00!)
		GOTO OBJECT:C206(*; "DOB")
	Else 
		If ([Customers:3]Salutation:2="")
			GOTO OBJECT:C206(*; "salutation")
		Else 
			If ([Customers:3]Gender:120="")
				GOTO OBJECT:C206(*; "Gender")
			End if 
		End if 
	End if 
	
End if 

//C_TEXT(vErrorAndWarnings)

checkInit
validateCustomerKYC
//vErrorAndWarnings:=checkGetErrorString+checkGetWarningString
setVisibleIff((Not:C34(checkErrorExist) & (Not:C34(checkWarningExist))); "profileApproved@")
If ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4))
	highlightMissingFieldsInCustKYC
	VPROGRESSBAR:=cbCompanyOK+cbContactOK+cbAddressOK+cbPictureIDOK+Num:C11([Customers:3]isDocumentsVerified:109)
End if 

If (Form event code:C388=On Deactivate:K2:10)
	
End if 