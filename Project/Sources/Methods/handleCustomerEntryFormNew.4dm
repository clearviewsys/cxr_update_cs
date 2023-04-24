//%attributes = {}

HandleEntryFormMethod(->[Customers:3]; ->[Customers:3]CreatedByUserID:58; ->[Customers:3]ModifiedByUserID:59; ->[Customers:3]BranchID:86; ->[Customers:3]modBranchID:111)

C_BOOLEAN:C305($isComplianceOfficer)
C_TEXT:C284(vInvoiceNumber)
C_LONGINT:C283(cust_vRiskRating)

If (Form event code:C388=On Load:K2:1)
	
	READ WRITE:C146([LinkedDocs:4])  // THIS IS SUPER IMPORTANT
	READ ONLY:C145([CSMRelations:89])  // added by TB Nov 2018
	READ ONLY:C145([CallLogs:51])
	C_TEXT:C284(IM_KYCId; IM_fraudRule; IM_KYC_state)
	IM_KYCId:=""
	IM_fraudRule:=""
	IM_KYC_state:=""
	
	
	If (vInvoiceNumber="")  // this check is necessary to make sure the customer is not created from a new invoice
		// the transaction is necessary for multiple picture ID's
		// however when a new customer is created from a new invoice there's two START Transactions
		//STARTTRANSACTION
	End if 
	loadPictureIDsforCurrentCustome
	clearPictureIDVars
	
	If (Is new record:C668([Customers:3]))  // when it's a new record
		[Customers:3]CustomerID:1:=makeCustomerID
	Else   // record is being modified
		If ([Customers:3]CustomerID:1=getWalkInCustomerID)
			myAlert("The walk-in profile should not be edited!!!")
			OBJECT SET ENABLED:C1123([Customers:3]FirstName:3; False:C215)
			OBJECT SET ENABLED:C1123([Customers:3]LastName:4; False:C215)
		End if 
		[Customers:3]isDocumentsVerified:109:=False:C215  // reset the validation when modifying a record
		[Customers:3]DocumentsVerifiedBy:110:=""  // reset the last person that validated the record
	End if 
	C_BOOLEAN:C305($cond)
	$cond:=(isUserManager | isUserComplianceOfficer)
	setEnterableIff($cond; "isAccount")
	setEnterableIff($cond; "doNotReport")
	setVisibleIff($cond; "isSelf")
	// getBuild
	
	GOTO OBJECT:C206(*; "vTitle")
	
End if 

If ((Form event code:C388=On Load:K2:1))
	handleSizeOfImageVar(->vSizeOfImage; ->[Customers:3]PictureID_Image:53; "vSizeOfImage")
	
	getLatestCheckLogStatusIcon(Table:C252(->[Customers:3]); [Customers:3]CustomerID:1; ->latestCheckStatus1; makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4))
	getLatestCheckLogStatusIcon(Table:C252(->[Customers:3]); [Customers:3]CustomerID:1; ->latestCheckStatus2; [Customers:3]CompanyName:42)
	
	// vvvvv Crushes 4D if `Form event code = Outside Call` vvvv
	getAllCheckLogByID(Table:C252(->[Customers:3]); [Customers:3]CustomerID:1)
	
	//colourizeObjectBGIff ("onHold@";[Customers]isOnHold=True)
End if 
If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11))
	//setVisibleIff ([Customers]isFavorite;"flag")
	setVisibleIff([Customers:3]isCompany:41; "icon_company")
	setVisibleIff([Customers:3]isCompany:41; "compis@")
	setVisibleIff([Customers:3]isAccount:34; "isAccountSign")
	handleCustomerRedFlagSigns
	drawRiskBar("riskBar"; [Customers:3]AML_RiskRating:75)
	OBJECT SET TITLE:C194(*; "RiskRatingLabel"; getRiskRatingString([Customers:3]AML_RiskRating:75))
	
	// show only to compliance officers
	$isComplianceOfficer:=isUserComplianceOfficer
	setEnterableIff($isComplianceOfficer; "isHighRisk")
	setEnterableIff($isComplianceOfficer; "isPEP")
	setEnterableIff($isComplianceOfficer; "isHIO")
	setEnterableIff($isComplianceOfficer; "AML_ignoreRepeatTransWarn")
	
	
	// Identity Mind Fields
	C_BOOLEAN:C305($IM_activated)
	$IM_activated:=(getKeyValue("identityMind.activated"; "false")="true")
	setVisibleIff($IM_activated; "b_sendtoIM")
	setVisibleIff($IM_activated; "l_IM_KYCId")
	setVisibleIff($IM_activated; "v_IM_KYCId")
	setVisibleIff($IM_activated; "l_IM_fraudRule")
	setVisibleIff($IM_activated; "v_IM_fraudRule")
	setVisibleIff($IM_activated; "v_IM_KYCState")
	setVisibleIff($IM_activated; "l_IM_KYCState")
	setVisibleIff($IM_activated; "b_retrieveIM")
	setVisibleIff($IM_activated; "b_showIMdetails")
	setVisibleIff($IM_activated; "l_IM_KYC_id")
	setVisibleIff($IM_activated; "t_IM_fraudRule")
	IM_preformKYCRelatedTasks("onLoad")
	
	
	C_LONGINT:C283($tab)
	$tab:=OBJECT Get pointer:C1124(Object named:K67:5; "tabControl")->
	
	Case of 
		: ($tab=1)  // pictureID
			relateManyLinkedDocs
			
		: ($tab=2)  // corporate entity
			QUERY:C277([CSMRelations:89]; [CSMRelations:89]CustomerID1:2=[Customers:3]CustomerID:1; *)
			QUERY:C277([CSMRelations:89];  | ; [CSMRelations:89]CustomerID2:3=[Customers:3]CustomerID:1)
			orderByCSMRelations
			
		: ($tab=3)  // comments and notes
			relateCustomerNotes
			
		: ($tab=4)  // Banking Info
			relateMany(->[WireTemplates:42]; ->[WireTemplates:42]CustomerID:2; ->[Customers:3]CustomerID:1)
			
		: ($tab=5)  // AML/ Risk
			relateManySanctionCheckLogs
			
		: ($tab=6)
			
	End case 
End if 

//Form.sanctionCheckCompleted:=slold_handleCheckCompleteEvent(->[Customers]CustomerID; ->latestCheckStatus1)


