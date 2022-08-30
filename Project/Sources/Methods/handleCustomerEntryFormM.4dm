//%attributes = {}

HandleEntryFormMethod(->[Customers:3]; ->[Customers:3]CreatedByUserID:58; ->[Customers:3]ModifiedByUserID:59; ->[Customers:3]BranchID:86; ->[Customers:3]modBranchID:111)

C_TEXT:C284(vInvoiceNumber)
C_LONGINT:C283(cust_vRiskRating)

If (Form event code:C388=On Load:K2:1)
	
	
	If (vInvoiceNumber="")  // this check is necessary to make sure the customer is not created from a new invoice
		// the transaction is necessary for multiple picture ID's
		// however when a new customer is created from a new invoice there's two START Transactions
		//STARTTRANSACTION
	End if 
	READ WRITE:C146([LinkedDocs:4])  // THIS IS SUPER IMPORTANT
	loadPictureIDsforCurrentCustome
	clearPictureIDVars
	
	If (Record number:C243([Customers:3])>=0)  // modify record
		
		If ([Customers:3]CustomerID:1=getWalkInCustomerID)
			myAlert("The walk-in profile should not be edited!!!")
			OBJECT SET ENABLED:C1123([Customers:3]FirstName:3; False:C215)
			OBJECT SET ENABLED:C1123([Customers:3]LastName:4; False:C215)
		End if 
		[Customers:3]isDocumentsVerified:109:=False:C215  // reset the validation when modifying a record
		[Customers:3]DocumentsVerifiedBy:110:=""  // reset the last person that validated the record
		//RELATE ONE([Customers]OccupationCode)
		//RELATE ONE([Customers]IndustryCode)
	Else   // new record
		[Customers:3]CustomerID:1:=makeCustomerID
	End if 
	
	GOTO OBJECT:C206(*; "vTitle")
	
	getLatestCheckLogStatusIcon(Table:C252(->[Customers:3]); [Customers:3]CustomerID:1; ->latestCheckStatus1; makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4))
	getLatestCheckLogStatusIcon(Table:C252(->[Customers:3]); [Customers:3]CustomerID:1; ->latestCheckStatus2; [Customers:3]CompanyName:42)
	
	getAllCheckLogByID(Table:C252(->[Customers:3]); [Customers:3]CustomerID:1)
	
	
End if 

//If (onNewRecordEvent )
//[Customers]Country:=<>companyCountry
//[Customers]CountryOfResidence:=<>companyCountry
//End if 
handleRiskRatingDial(->cust_vRiskRating; ->[Customers:3]AML_RiskRating:75)

colourizeObjectBGIff("onHold@"; [Customers:3]isOnHold:52=True:C214)

setVisibleIff([Customers:3]isFavorite:68; "flag")
setVisibleIff([Customers:3]isCompany:41; "icon_company")
setVisibleIff([Customers:3]isCompany:41; "compis@")

setVisibleIff(([Customers:3]AML_HighRisk:24=1) | ([Customers:3]AML_RiskRating:75>3); "Icon_HighRisk")
setVisibleIff(([Customers:3]AML_isPEP:80=1) | ([Customers:3]AML_isHIO:124=1); "Icon_PEP")

handleSizeOfImageVar(->vSizeOfImage; ->[Customers:3]PictureID_Image:53; "vSizeOfImage")



If (Form event code:C388=On Outside Call:K2:11)
	QUERY:C277([CSMRelations:89]; [CSMRelations:89]CustomerID1:2=[Customers:3]CustomerID:1; *)
	QUERY:C277([CSMRelations:89];  | ; [CSMRelations:89]CustomerID2:3=[Customers:3]CustomerID:1)
	orderByCSMRelations
	
	relateManyLinkedDocs
	//RELATE ONE([Customers]OccupationCode)
	//RELATE ONE([Customers]IndustryCode)
	relateManySanctionCheckLogs
End if 

handleCustomerEntryTab