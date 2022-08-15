//%attributes = {}


// #ORDA

C_TEXT:C284($1; $WebEwireID)
C_BOOLEAN:C305($2; $doSave)

C_LONGINT:C283($0; $iError)

C_BLOB:C604($xBlob)


$WebEwireID:=$1

If (Count parameters:C259>=2)
	$doSave:=$2
Else 
	$doSave:=True:C214
End if 

$iError:=0

READ WRITE:C146([WebEWires:149])

If ($WebEwireID=[WebEWires:149]WebEwireID:1)  //all good we have the record
Else 
	QUERY:C277([WebEWires:149]; [WebEWires:149]WebEwireID:1=$WebEwireID)
End if 



If ($WebEwireID=[WebEWires:149]WebEwireID:1)  //(Records in selection([WebEWires])=1)
	
	If (Locked:C147([WebEWires:149]))
		LOAD RECORD:C52([WebEWires:149])  //try once to see if we can get a lock
	End if 
	
	If (Locked:C147([WebEWires:149]))  //still don't have access send back an error
		$iError:=-1
	Else   //we have edit access
		//CREATE RECORD([eWires])
		If ([eWires:13]eWireID:1="")
			[eWires:13]eWireID:1:=makeeWireID
		End if 
		
		[eWires:13]WebEwireID:123:=[WebEWires:149]WebEwireID:1
		
		[eWires:13]SendDate:2:=Current date:C33
		[eWires:13]SendTime:3:=Current time:C178
		
		[eWires:13]LinkID:8:=[WebEWires:149]LinkID:25
		QUERY:C277([Links:17]; [Links:17]LinkID:1=[eWires:13]LinkID:8)
		
		[eWires:13]AgentID:26:=[WebEWires:149]agentID:29
		[eWires:13]CustomerID:15:=[WebEWires:149]CustomerID:21
		
		[eWires:13]BranchID:50:=""
		[eWires:13]createdByUser:51:=""
		[eWires:13]Subject:6:=""
		[eWires:13]Author:4:=[WebEWires:149]author:34
		[eWires:13]comments_Visible:48:=[WebEWires:149]Notes:17
		[eWires:13]comments_Private:47:="Created from WebEwire: "+[WebEWires:149]WebEwireID:1
		[eWires:13]isPaymentSent:20:=True:C214
		
		//---- SENDER INFORMATION ----
		If (True:C214)
			[eWires:13]SenderName:7:=OB Get:C1224([WebEWires:149]fromParty:7; Info_FullName)
			[eWires:13]senderAddress:96:=OB Get:C1224([WebEWires:149]fromParty:7; Info_Address)
			[eWires:13]senderPhone:97:=OB Get:C1224([WebEWires:149]fromParty:7; Info_CellPhone)
			[eWires:13]senderCity:98:=OB Get:C1224([WebEWires:149]fromParty:7; Info_City)
			[eWires:13]senderState:99:=OB Get:C1224([WebEWires:149]fromParty:7; Info_State)
			[eWires:13]senderPostalCode:100:=OB Get:C1224([WebEWires:149]fromParty:7; Info_PostalCode)
			[eWires:13]senderDOB:101:=Date:C102(OB Get:C1224([WebEWires:149]fromParty:7; Info_DateOfBirth))
			[eWires:13]senderEmail:102:=OB Get:C1224([WebEWires:149]fromParty:7; Info_Email)
			[eWires:13]senderGovernmentID:103:=OB Get:C1224([WebEWires:149]fromParty:7; Info_GovernmentID)
			[eWires:13]senderGovernmentIDType:104:=OB Get:C1224([WebEWires:149]fromParty:7; Info_GovernmentIDType)
		End if 
		
		
		//---- AML INFORMATION ----
		If (True:C214)
			If (True:C214)
				[eWires:13]PurposeOfTransaction:65:=OB Get:C1224([WebEWires:149]AML_Info:9; AML_purposeOfTransaction)
				[eWires:13]AMLsourceOfFunds:94:=OB Get:C1224([WebEWires:149]AML_Info:9; AML_sourceOfFunds)
			Else 
				QUERY:C277([List_POT:128]; [List_POT:128]Code:2=OB Get:C1224([WebEWires:149]AML_Info:9; AML_purposeOfTransaction))
				[eWires:13]PurposeOfTransaction:65:=[List_POT:128]Purpose:3
				QUERY:C277([List_SOF:129]; [List_SOF:129]Code:2=OB Get:C1224([WebEWires:149]AML_Info:9; AML_sourceOfFunds))
				[eWires:13]AMLsourceOfFunds:94:=[List_SOF:129]Source:3
			End if 
			
			[eWires:13]fromMOP_Code:113:=OB Get:C1224([WebEWires:149]AML_Info:9; AML_fromMOPCode)
			[eWires:13]toMOP_Code:114:=OB Get:C1224([WebEWires:149]AML_Info:9; AML_toMOPCode)
			QUERY:C277([PaymentTypes:116]; [PaymentTypes:116]Code:2=[eWires:13]fromMOP_Code:113)
			[eWires:13]fromMOP:115:=[PaymentTypes:116]PaymentType:3
			QUERY:C277([PaymentTypes:116]; [PaymentTypes:116]Code:2=[eWires:13]toMOP_Code:114)
			[eWires:13]toMOP:116:=[PaymentTypes:116]PaymentType:3
		End if 
		
		
		// --- BENEFICIARY [TO] INFORMATION ---
		If (True:C214)
			[eWires:13]BeneficiaryFullName:5:=OB Get:C1224([WebEWires:149]toParty:8; Info_FullName)
			[eWires:13]BeneficiaryCompanyName:92:=OB Get:C1224([WebEWires:149]toParty:8; Info_CompanyName)
			[eWires:13]isBeneficiaryCompany:93:=(OB Get:C1224([WebEWires:149]toParty:8; Info_isCompany)="TRUE")
			//[eWires]BeneficiaryAmendedName:=
			[eWires:13]BeneficiaryGender:108:=OB Get:C1224([WebEWires:149]toParty:8; Info_Gender)
			[eWires:13]BeneficiarySalutation:109:=OB Get:C1224([WebEWires:149]toParty:8; Info_Salutation)
			[eWires:13]BeneficiaryDOB:110:=Date:C102(OB Get:C1224([WebEWires:149]toParty:8; Info_DateOfBirth))
			[eWires:13]BeneficiaryAddress:59:=OB Get:C1224([WebEWires:149]toParty:8; Info_Address)
			[eWires:13]BeneficiaryCity:60:=OB Get:C1224([WebEWires:149]toParty:8; Info_City)
			[eWires:13]BeneficiaryCellPhone:61:=OB Get:C1224([WebEWires:149]toParty:8; Info_CellPhone)
			//[eWires]BeneficiaryUNICODEName:=
			[eWires:13]BeneficiaryEmail:63:=OB Get:C1224([WebEWires:149]toParty:8; Info_Email)
			[eWires:13]BeneficiaryRelationship:64:=OB Get:C1224([WebEWires:149]toParty:8; Info_Relationship)
		End if 
		
		
		// --- DELIVERY INFORMATION ---- 
		If (True:C214)
			[eWires:13]doDeliverToAddress:32:=False:C215
			[eWires:13]DeliveryAddress:37:=""
			
			[eWires:13]doTransferToBank:33:=Choose:C955(OB Get:C1224([WebEWires:149]toBankingInfo:24; Bank_doTransferToBank)="on"; True:C214; False:C215)
			If ([eWires:13]toMOP_Code:114=getKeyValue("web.customers.webewires.tomop.bank"))
				[eWires:13]doTransferToBank:33:=True:C214
			End if 
			[eWires:13]BeneficiaryBankAccountNo:66:=OB Get:C1224([WebEWires:149]toBankingInfo:24; Bank_AccountNo)
			[eWires:13]BeneficiarySWIFT:105:=OB Get:C1224([WebEWires:149]toBankingInfo:24; Bank_Swift)
			[eWires:13]BeneficiaryBankDetails:38:=OB Get:C1224([WebEWires:149]toBankingInfo:24; Bank_Details)
			[eWires:13]BeneficiaryBankName:76:=OB Get:C1224([WebEWires:149]toBankingInfo:24; Bank_Name)
			[eWires:13]BeneficiaryBankTransitCode:77:=OB Get:C1224([WebEWires:149]toBankingInfo:24; Bank_TransitCode)
			//WHAT ABOUT ROUTING NUMBER AND OTHER BANK INFO... 
		End if 
		
		//---- THIRD PARTY INFORMATION ----
		If (True:C214)
			[eWires:13]isThirdPartyInvolved:67:=(OB Get:C1224([WebEWires:149]toThirdParty:23; Info_DoSendToThirdParty)="on")
			If ([eWires:13]isThirdPartyInvolved:67)
				[eWires:13]ThirdPartyDetails:68:=OB Get:C1224([WebEWires:149]toThirdParty:23; Info_FullName)+Char:C90(Carriage return:K15:38)+OB Get:C1224([WebEWires:149]toThirdParty:23; Info_Address)
				[eWires:13]ThirdPartyDetails:68:=[eWires:13]ThirdPartyDetails:68+Char:C90(Carriage return:K15:38)+OB Get:C1224([WebEWires:149]toThirdParty:23; Info_City)+", "+OB Get:C1224([WebEWires:149]toThirdParty:23; Info_State)
				[eWires:13]ThirdPartyDetails:68:=[eWires:13]ThirdPartyDetails:68+OB Get:C1224([WebEWires:149]toThirdParty:23; Info_PostalCode)
			End if 
		End if 
		
		// ---- MONEY INFORMATION -----
		If (True:C214)
			[eWires:13]isPaymentSent:20:=[WebEWires:149]isSent:22
			//[eWires]fromCountry:=getCountryNameByCode ([WebEWires]fromCountryCode)
			//[eWires]toCountry:=getCountryNameByCode ([WebEWires]toCountryCode)
			[eWires:13]FromCurrency:11:=[WebEWires:149]fromCCY:5
			[eWires:13]Currency:12:=[WebEWires:149]toCCY:11
			[eWires:13]FromAmount:13:=[WebEWires:149]fromAmount:3
			[eWires:13]amountLocal:45:=[eWires:13]FromAmount:13
			
			[eWires:13]ToAmount:14:=[WebEWires:149]toAmount:10
			[eWires:13]sourceRate:41:=[WebEWires:149]directRate:13
			[eWires:13]sourceServicefeeLocal:44:=[WebEWires:149]fromFee:6
			
			//[eWires]sourceSpotRate:=
			//[eWires]sourcePCTFee:=
			//[eWires]sourceSpotRate:=
			//[eWires]destinationRate:=
			//[eWires]destinationPctFee:=
			//[eWires]DestinationServiceFee:=
			//[eWires]destinationSpotRate:=
			
			
			[eWires:13]fromCountryCode:111:=[WebEWires:149]fromCountryCode:4
			[eWires:13]toCountryCode:112:=[WebEWires:149]toCountryCode:12
			[eWires:13]toCountry:10:=getCountryNameByCode([eWires:13]toCountryCode:112)
			[eWires:13]fromCountry:9:=getCountryNameByCode([eWires:13]fromCountryCode:111)
			
			//:=[WebEWires]inverseRate
		End if 
		
		
		C_OBJECT:C1216($entity)
		$entity:=ds:C1482.Accounts.query("CurrencyAlias == :1"; getKeyValue("ewire.currency.alias.prefix")+[WebEWires:149]toCCY:11)
		
		If ($entity.length>1)
			$entity:=$entity.query("AgentID # :1"; "")
		End if 
		
		If ($entity.length=1)
			[eWires:13]AccountID:30:=$entity.first().AccountID
			[eWires:13]AgentID:26:=$entity.first().AgentID
		End if 
		
		
		// ---- ATTACHMENTS -------
		QUERY:C277([WebAttachments:86]; [WebAttachments:86]RelatedTableNum:11=Table:C252(->[WebEWires:149]); *)
		QUERY:C277([WebAttachments:86];  & ; [WebAttachments:86]RelatedID:2=[WebEWires:149]WebEwireID:1)
		
		If (Records in selection:C76([WebAttachments:86])>0)
			//get first attachment and convert here
			$xBlob:=getWebAttachmentFromServer([WebAttachments:86]FilePath:3)  //
			//really should test for picture type so as not to try to put a PDF or other in a pict field
			BLOB TO PICTURE:C682($xBlob; [eWires:13]AttachedPicture:25)
		End if 
		
		
		//---- FIELDS WITHOUT CORRESPONDING DATA ----
		If (False:C215)
			//[eWires]phoneNumber:=
			//[eWires]CustomerMsg:=
			//[eWires]LinkMsg:=
			//[eWires]ReceiveDate:=
			//[eWires]ReceiveTime:=
			//[eWires]DestinationServiceFee:=
			//[eWires]Status:=
			//[eWires]isSettled:=
			//[eWires]RegisterID:=
			//[eWires]isFlagged:=
			//[eWires]ReferenceNo:=
			//[eWires]InvoiceNumber:=
			//[eWires]AccountID:=
			//[eWires]doNotifyBySMS:=
			//[eWires]isCancelled:=
			//[eWires]isUnlisted:=
			//[eWires]priority:=
			//[eWires]AgentInternalRef:=
			//[eWires]sourceSpotRate:=
			//[eWires]sourcePCTFee:=
			//[eWires]amountLocal:=
			//[eWires]isCustomerNotifiedByPhone:=
			//
			//[eWires]includedInAgentPO:=
			//[eWires]didCheckAgainstSanctionList:=
			//[eWires]didMatchWithSanctionList:=
			//[eWires]sanctionCheckResultString:=
			//[eWires]needsApproval:=
			//[eWires]isOnHold:=
			//[eWires]ReasonForPuttingOnHold:=
			//[eWires]securityChallengeCode:=
			//[eWires]isFalsePositiveMatch:=
			//[eWires]isLocked:=
			//[eWires]lockedDate:=
			//[eWires]lockedTime:=
			//[eWires]lockedIP:=
			//[eWires]lockedSite:=
			//[eWires]customerID_origin:=
			//[eWires]linkID_origin:=
			//[eWires]invoiceID_origin:=
			//[eWires]destinationRate:=
			//[eWires]destinationAmountLocal:=
			//[eWires]destinationSpotRate:=
			//[eWires]destinationPctFee:=
			//[eWires]registerID_origin:=
			//[eWires]modBranchID:=
			//[eWires]wasReported:=
			//[eWires]SubAccountID:=
			//[eWires]CounterAccountID:=
			//[eWires]eWireStatus:=
		End if 
		
		//SAVE RECORD([eWires])
		
		[WebEWires:149]eWireID:18:=[eWires:13]eWireID:1
		[WebEWires:149]status:16:=30
		[WebEWires:149]paymentInfo:35.invoiceID:=[Invoices:5]InvoiceID:1
		
		If ($doSave)
			SAVE RECORD:C53([WebEWires:149])
			//UNLOAD RECORD([eWires])
			UNLOAD RECORD:C212([WebEWires:149])
			READ ONLY:C145([WebEWires:149])
			//READ ONLY([eWires])
			LOAD RECORD:C52([WebEWires:149])
			//LOAD RECORD([eWires])
		End if 
		
	End if 
End if 


$0:=$iError