//%attributes = {}
// validateCustomerKYC (duringReview:bool)

C_BOOLEAN:C305($duringReview; $1)

Case of 
	: (Count parameters:C259=0)
		$duringReview:=False:C215
	: (Count parameters:C259=1)
		$duringReview:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_BOOLEAN:C305(<>doCheckCustomerProfile; <>DOFINTRACCHECKS)
If ((Not:C34([Customers:3]isAccount:34)) & (Not:C34([Customers:3]AML_ignoreKYC:35)))
	If (<>DOFINTRACCHECKS)  // FINTRAC compliancy checks
		
		If ([Customers:3]isCompany:41=False:C215)  // only for individuals.
			
			If (<>doCheckCustomerProfile)
				checkAddWarningOnTrue([Customers:3]Occupation:21=""; "KYC: The customer's occupation is left blank.")
				checkAddWarningOnTrue([Customers:3]DOB:5=nullDate; "KYC: Customer Date of Birth is left blank. (Very important)")
				checkAddWarningOnTrue(([Customers:3]PictureID_Number:69=""); "KYC Picture ID: The main Picture ID is missing.")
				checkAddWarningOnTrue(([Customers:3]PictureID_ExpiryDate:71=!00-00-00!); "KYC Picture ID: Expiry Date is missing.")
				checkAddWarningOnTrue(([Customers:3]PictureID_Type:70=""); "KYC Picture ID: Type of Picture ID is missing.")
				checkAddWarningOnTrue(([Customers:3]PictureID_IssueState:72=""); "KYC Picture ID: Place of issue is missing.")
				
				C_TEXT:C284($strict)
				$strict:=getKeyValue("amlrule.pictureIDExpDate"; "loose")
				If ($strict="strict")
					checkAddErrorIf(isDateExpired([Customers:3]PictureID_ExpiryDate:71); "KYC: Picture ID for this customer has expired!")
				Else 
					checkAddWarningOnTrue(isDateExpired([Customers:3]PictureID_ExpiryDate:71); "KYC:  Picture ID expired!")
				End if 
				
				checkAddWarningOnTrue([Customers:3]Address:7=""; "KYC Address: Main address is left blank.")
				checkAddWarningOnTrue([Customers:3]City:8=""; "KYC Address: CITY is left blank.")
				checkAddWarningOnTrue([Customers:3]CountryCode:113=""; "KYC Address: Country Code is left blank.")
				checkIfValidDOB([Customers:3]DOB:5; "Customer's DOB")
			End if 
			
			If ($duringReview=False:C215)  // if we are reviewing a customer we shouldn't get the error that the customer needs to be reviewed
				$strict:=getKeyValue("amlrule.ProfileReview"; "strict")
				// amlRule.reviewprofile
				If ($strict="strict")
					checkAddErrorIf(isCustomerDueForKYCReview; "This profile must be Reviewed before doing any transactions!")
				Else 
					checkAddWarningOnTrue(isCustomerDueForKYCReview; "It is about time to review this customer's profile!")
				End if 
			End if 
			
			
		End if 
		checkAddWarningOnTrue([Customers:3]isOnHold:52; "Customer ON HOLD. Reason: <X>"; [Customers:3]AML_OnHoldNotes:127)
		checkAddWarningOnTrue([Customers:3]AML_hasPositiveMatchOnSL:92; "Note that customer is on sanction list")
	End if   // end doFINTRACChecks
End if   // isAccount
// don't allow due diligence to be left blank when a customer is on the sanction list
//checkAddErrorIf (([Customers]hasAMatchOnSanctionList & [Customers]FINTRACNote="");"Please provide due diligence information")

// check if last validation of sanction list is too old
