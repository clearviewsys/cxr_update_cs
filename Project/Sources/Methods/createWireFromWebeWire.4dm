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
		If ([Wires:8]CXR_WireID:1="")
			[Wires:8]CXR_WireID:1:=makeWiresID
		End if 
		
		[Wires:8]CustomerID:2:=[WebEWires:149]CustomerID:21
		
		C_OBJECT:C1216($entity)
		$entity:=ds:C1482.Accounts.query("CurrencyAlias == :1"; getKeyValue("wire.currency.alias.prefix")+[WebEWires:149]toCCY:11)
		If ($entity.length=1)
			[Wires:8]CXR_AccountID:11:=$entity.first().AccountID
		End if 
		
		If (False:C215)
			[Wires:8]CXR_AccountID:11:=""
			[Wires:8]CXR_InvoiceID:12:=""
			[Wires:8]CXR_RegisterID:13:=""
			[Wires:8]BranchID:47:=""
			[Wires:8]CXR_SubAccountID:61:=""
		End if 
		
		[Wires:8]AutoComments:20:="Created from web: "+[WebEWires:149]WebEwireID:1
		//[eWires]WebEwireID:=[WebEWires]WebEwireID
		
		[Wires:8]WireTemplateID:83:=[WebEWires:149]LinkID:25  // using LINKS not WireTemplates from web
		QUERY:C277([Links:17]; [Links:17]LinkID:1=[Wires:8]WireTemplateID:83)
		
		
		//---- SENDER INFORMATION ----
		If (True:C214)
			[Wires:8]OriginatorFullName:34:=OB Get:C1224([WebEWires:149]fromParty:7; Info_FullName)
			[Wires:8]OriginatorAddress:36:=OB Get:C1224([WebEWires:149]fromParty:7; Info_Address)
			[Wires:8]OriginatorCity:37:=OB Get:C1224([WebEWires:149]fromParty:7; Info_City)
			[Wires:8]OriginatorState:38:=OB Get:C1224([WebEWires:149]fromParty:7; Info_State)
			[Wires:8]originatorCountryCode:84:=OB Get:C1224([WebEWires:149]fromParty:7; Info_CountryCodeOfResidence)
			[Wires:8]OriginatorCountry:39:=getCountryNameByCode([Wires:8]originatorCountryCode:84)
			[Wires:8]OriginatorZIP:40:=OB Get:C1224([WebEWires:149]fromParty:7; Info_PostalCode)
			
			//[Wires]OriginatorIdentifier:=
			//[Wires]CorrespondentBankName:=
			//[Wires]CorrespondentBankIdentifier:=
			//[Wires]OriginatingBankName:=
			//[Wires]OriginatingBankID:=
			//[Wires]OriginatingBankAddress:=
			//[Wires]OriginatingBankCountry:=
			//[Wires]OriginatingBankCountryCode:=
		End if 
		
		
		//---- AML INFORMATION ----
		If (True:C214)
			[Wires:8]AML_PurposeOfTransaction:49:=OB Get:C1224([WebEWires:149]AML_Info:9; AML_purposeOfTransaction)
			[Wires:8]AML_SourceOfFunds:66:=OB Get:C1224([WebEWires:149]AML_Info:9; AML_sourceOfFunds)
			[Wires:8]AML_isSanctionListChecked:54:=False:C215
			[Wires:8]AML_didMatchOnWatchList:55:=False:C215
			[Wires:8]AML_isFalsePositive:56:=False:C215
			[Wires:8]AML_DueDiligence:57:=""
			[Wires:8]AML_WatchListResult:58:=""
			
			[Wires:8]fromMOP_Code:79:=OB Get:C1224([WebEWires:149]AML_Info:9; AML_fromMOPCode)
			[Wires:8]toMOP_Code:80:=OB Get:C1224([WebEWires:149]AML_Info:9; AML_toMOPCode)
			
			QUERY:C277([PaymentTypes:116]; [PaymentTypes:116]Code:2=[Wires:8]fromMOP_Code:79)
			[Wires:8]fromMOP:81:=[PaymentTypes:116]PaymentType:3
			QUERY:C277([PaymentTypes:116]; [PaymentTypes:116]Code:2=[Wires:8]toMOP_Code:80)
			[Wires:8]toMOP:82:=[PaymentTypes:116]PaymentType:3
		End if 
		
		
		// --- BENEFICIARY [TO] INFORMATION ---
		If (True:C214)
			If ((OB Get:C1224([WebEWires:149]toParty:8; Info_isCompany)="true"))
				[Wires:8]isBeneficiaryEntity:71:=True:C214
				[Wires:8]BeneficiaryFullName:10:=OB Get:C1224([WebEWires:149]toParty:8; Info_CompanyName)
				If ([Wires:8]BeneficiaryFullName:10="")
					[Wires:8]BeneficiaryFullName:10:=OB Get:C1224([WebEWires:149]toParty:8; Info_FullName)
				End if 
			Else 
				[Wires:8]BeneficiaryFullName:10:=OB Get:C1224([WebEWires:149]toParty:8; Info_FullName)
			End if 
			[Wires:8]BeneficiaryAddress:26:=OB Get:C1224([WebEWires:149]toParty:8; Info_Address)
			[Wires:8]BeneficiaryCity:50:=OB Get:C1224([WebEWires:149]toParty:8; Info_City)
			[Wires:8]BeneficiaryState:51:=OB Get:C1224([WebEWires:149]toParty:8; Info_State)
			[Wires:8]BeneficiaryZIPCode:52:=OB Get:C1224([WebEWires:149]toParty:8; Info_PostalCode)
			[Wires:8]BeneficiaryCountryCode:78:=OB Get:C1224([WebEWires:149]toParty:8; Info_CountryCode)
			[Wires:8]BeneficiaryCountry:53:=getCountryNameByCode([Wires:8]BeneficiaryCountryCode:78)
			[Wires:8]BeneficiaryPhone:69:=OB Get:C1224([WebEWires:149]toParty:8; Info_CellPhone)
			[Wires:8]BeneficiaryGender:72:=OB Get:C1224([WebEWires:149]toParty:8; Info_Gender)
			[Wires:8]BeneficiarySalutation:73:=OB Get:C1224([WebEWires:149]toParty:8; Info_Salutation)
			[Wires:8]BeneficiaryDOB:74:=Date:C102(OB Get:C1224([WebEWires:149]toParty:8; Info_DateOfBirth))
			[Wires:8]AML_RelationshipWithSender:67:=OB Get:C1224([WebEWires:149]toParty:8; Info_Relationship)
			//[Wires]BeneficiaryBranchPhone:=
			//[Wires]BeneficiaryBranchFax:=
			//[Wires]BeneficiaryBranchID:=
			
		End if 
		
		
		// --- DELIVERY INFORMATION ---- 
		//If ((OB Get([WebEWires]toBankingInfo;Bank_doTransferToBank)="on"))
		//  //this is given b/c it's a wire
		//End if 
		[Wires:8]BeneficiaryBankName:3:=OB Get:C1224([WebEWires:149]toBankingInfo:24; Bank_Name)
		[Wires:8]BeneficiaryBankAddress:4:=OB Get:C1224([WebEWires:149]toBankingInfo:24; Bank_Address)
		[Wires:8]BeneficiaryBankCityState:5:=OB Get:C1224([WebEWires:149]toBankingInfo:24; Bank_City)
		[Wires:8]BeneficiaryBankCountryCode:77:=OB Get:C1224([WebEWires:149]toBankingInfo:24; Bank_CountryCode)
		If ([Wires:8]BeneficiaryBankCountryCode:77="")
			[Wires:8]BeneficiaryBankCountryCode:77:=[Wires:8]BeneficiaryCountryCode:78
		End if 
		[Wires:8]BeneficiaryBankCountry:6:=getCountryNameByCode([Wires:8]BeneficiaryBankCountryCode:77)
		[Wires:8]BeneficiaryInstitutionNo:7:=""
		[Wires:8]BeneficiaryBranchTransitNo:8:=OB Get:C1224([WebEWires:149]toBankingInfo:24; Bank_TransitCode)
		[Wires:8]BeneficiaryAccountNo:9:=OB Get:C1224([WebEWires:149]toBankingInfo:24; Bank_AccountNo)
		[Wires:8]BeneficiaryRoutingCode:27:=OB Get:C1224([WebEWires:149]toBankingInfo:24; Bank_TransitCode)
		[Wires:8]BeneficiarySWIFT:28:=OB Get:C1224([WebEWires:149]toBankingInfo:24; Bank_Swift)
		[Wires:8]FurtherCreditTo:32:=OB Get:C1224([WebEWires:149]toBankingInfo:24; Bank_Details)
		
		
		
		// ---- MONEY INFORMATION -----
		If (True:C214)
			[Wires:8]Amount:14:=[WebEWires:149]toAmount:10
			[Wires:8]Currency:15:=[WebEWires:149]toCCY:11
			[Wires:8]isOutgoingWire:16:=[WebEWires:149]isSent:22
			[Wires:8]WireTransferDate:17:=Current date:C33
			[Wires:8]EstimatedValueDate:18:=Current date:C33+1
			
			[Wires:8]OurRate:21:=[WebEWires:149]directRate:13
			[Wires:8]SpotRate:22:=[WebEWires:149]directRate:13
			[Wires:8]PercentageFee:23:=0
			[Wires:8]FlatFeeLocal:24:=[WebEWires:149]fromFee:6
			[Wires:8]AmountLocal:25:=[WebEWires:149]fromAmount:3
		End if 
		
		
		
		
		//---- FIELDS WITHOUT CORRESPONDING DATA ----
		If (False:C215)
			//[Wires]isVerified:=
			//[Wires]verfifiedBy:=
			//[Wires]isReleased:=
			//[Wires]ReleasedBy:=
			//[Wires]ReleasedDate:=
			//[Wires]wasReported:=
			//[Wires]Memo:=
			//[Wires]modBranchID:=
			
			//[Wires]CC_PaymentID:=
			//[Wires]CC_BeneficiaryID:=
			//[Wires]currencyCloudPurposeCode:=
		End if 
		
		//SAVE RECORD([eWires])
		
		[WebEWires:149]eWireID:18:=[Wires:8]CXR_WireID:1
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