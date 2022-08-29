//%attributes = {}
C_TEXT:C284(vPictureIDRef; vIDType; vInvoiceNumber)

//validatecustomers

checkInit

If (validateTable(->[Customers:3]; [Customers:3]isAccount:34))  // & Form.sanctionChecCompleted)  // validation should omit field constraints when customer is an account
	setTableBranchDateTimeEtc(->[Customers:3]; ->[Customers:3]BranchID:86; ->[Customers:3]CreationDate:54; ->[Customers:3]CreationTime:55; ->[Customers:3]CreatedByUserID:58; ->[Customers:3]ModificationDate:56; ->[Customers:3]ModificationTime:57; ->[Customers:3]ModifiedByUserID:59; ->[Customers:3]modBranchID:111)
	
	//createWebUserFromCustomer
	
	If (checkWarningExist)
		createRecordExceptionLog(->[Customers:3]; "Missing Info:Customer"; [Customers:3]CustomerID:1; [Customers:3]FullName:40+checkGetWarningString)
	End if 
	
	createNoteFromChangedField(->[Customers:3]isOnHold:52; ->[Customers:3]AML_OnHoldNotes:127; "ON HOLD")
	createNoteFromChangedField(->[Customers:3]AML_isSuspicious:49; ->[Customers:3]AML_SuspiciousNotes:125; "Suspicious")
	IM_preformKYCRelatedTasks("autoCheck")
	
	handleSaveCustomerAddress
	checkCustomerForRelations
	
	sl_handleCustomerScreening(sl_ForNextButton)
	//C_OBJECT($data)
	//$data:=New object("options"; New object("autoList"; "Customer"; "comfirmReject"; True))
	//C_LONGINT($result)
	//If ([Customers]isCompany)
	//sl_handleCompanyNameCompliance(False; [Customers]CompanyName; ->[Customers]CustomerID; $data)
	//Else
	//sl_handlePersonNameCompliance(False; [Customers]FullName; ->[Customers]CustomerID; $data)
	//End if
	
	//customerCheckChange   // still for checking
	If ([Customers:3]approvalStatus:146#Old:C35([Customers:3]approvalStatus:146))
		createOnChangeNotification(->[Customers:3])
	End if 
	
Else 
/*If (Not(Form.sanctionCheckCompleted))
myAlert("Sanction Check is still running.")
End if */
	REJECT:C38
End if 
