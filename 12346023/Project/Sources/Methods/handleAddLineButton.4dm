//%attributes = {}
//If (Form event=On Clicked )
//handleEditEntryInInvoice 

// getBuild

C_BOOLEAN:C305($isPaid)
C_BOOLEAN:C305(isInternalInvoice)
C_BOOLEAN:C305(isOK)  // this is my own OK varaible (boolean) which remembers if cancel is pressed or not
IsInternalInvoice:=[Invoices:5]isTransfer:42
C_TEXT:C284(vAML_POT; vAML_SOF)
vAML_POT:=""
vAML_SOF:=""

checkInit
validateAddLineInInvoice

If (isValidationConfirmed)
	
	
	If (getVecCurrencyString="")
		setVecCurrency(<>baseCurrency)
	End if 
	
	If (vAmount=0)  // this line simplifies the entry by automatically filling the pay off value when the amount is 0
		handlePayOffButton
	End if 
	
	If (vReceivedOrPaid=getReceivedOrPayString(2))
		$isPaid:=True:C214
	Else 
		$isPaid:=False:C215
	End if 
	
	C_TEXT:C284($vPaymentMethod)
	$vPaymentMethod:=vecPaymentMethod{vecPaymentMethod}
	
	Case of 
			
		: ($vPaymentMethod=c_Cash)
			checkInit
			checkAddErrorIf((vAmountLocal><>oneIDLimit) & (vCustomerID=getWalkInCustomerID) & <>doFINTRACchecks; "For this transaction customer must have a profile.")
			If (isValidationConfirmed)
				handlePaymentInInvoiceNew(->[CashTransactions:36]; ->[CashTransactions:36]InvoiceID:7; ->[CashTransactions:36]isPaid:2; $isPaid; True:C214)
			End if 
			
			
		: ($vPaymentMethod=c_Cheque)
			checkInit
			checkAddErrorIf((vCustomerID=getWalkInCustomerID) & (<>doAskCustIDForCheque); "For cheque transactions, customer must have a profile")
			If (isValidationConfirmed)
				handlePaymentInInvoiceNew(->[Cheques:1]; ->[Cheques:1]InvoiceID:5; ->[Cheques:1]isPaid:11; $isPaid; True:C214)
			End if 
			
			
		: ($vPaymentMethod=c_eWire)
			checkInit
			checkAddErrorIf((vCustomerID=getWalkInCustomerID) & (<>doAskCustIDForCheque); "For eWire transactions, customer must have a profile")
			If (isValidationConfirmed)
				handlePaymentInInvoiceNew(->[eWires:13]; ->[eWires:13]InvoiceNumber:29; ->[eWires:13]isPaymentSent:20; $isPaid; True:C214)
				
				If ([Invoices:5]AMLBeneficiaryName:99="")
					[Invoices:5]AMLBeneficiaryName:99:=[eWires:13]BeneficiaryFullName:5
				End if 
				
				If ([Invoices:5]AMLrelationship:98="")
					[Invoices:5]AMLrelationship:98:=[eWires:13]BeneficiaryRelationship:64
				End if 
				
				If ([Invoices:5]AMLCountryCode:87="")
					[Invoices:5]AMLCountryCode:87:=[eWires:13]toCountryCode:112
				End if 
				
				If ([Invoices:5]SourceOfFund:68="")
					[Invoices:5]SourceOfFund:68:=[eWires:13]AMLsourceOfFunds:94
				End if 
				
				If ([Invoices:5]AMLPurposeOfTransaction:85="")
					[Invoices:5]AMLPurposeOfTransaction:85:=[eWires:13]PurposeOfTransaction:65
				End if 
				
			End if 
			
		: ($vPaymentMethod=c_Wire)
			checkInit
			checkAddErrorIf((vCustomerID=getWalkInCustomerID) & (<>doAskCustIDForCheque); "For Wire transactions, customer must have a profile")
			If (isValidationConfirmed)
				handlePaymentInInvoiceNew(->[Wires:8]; ->[Wires:8]CXR_InvoiceID:12; ->[Wires:8]isOutgoingWire:16; $isPaid; True:C214)
			End if 
			
			[Invoices:5]AMLBeneficiaryName:99:=[Wires:8]BeneficiaryFullName:10
			[Invoices:5]AMLCountryCode:87:=[Wires:8]BeneficiaryCountryCode:78
			[Invoices:5]AMLrelationship:98:=[Wires:8]AML_RelationshipWithSender:67
			
		: ($vPaymentMethod=c_Account)
			// handlePaymentInInvoiceNew (->[AccountInOuts];->[AccountInOuts]InvoiceID;->[AccountInOuts]isPaid;$isPaid;True)
			
			// modified by @milan 04/14/21
			
			If (INV_vNextAccountCode="MGRAM")  // Added by @milan (4/5/21)
				
				handlePaymentInInvoiceMG
				
				C_OBJECT:C1216($mg)
				
				$mg:=[WebEWires:149]paymentInfo:35  // shortened access
				
				If ([Invoices:5]AMLBeneficiaryName:99="")
					[Invoices:5]AMLBeneficiaryName:99:=$mg.passedToMoneyGram.receiverFirstName+" "+$mg.passedToMoneyGram.receiverLastName
				End if 
				
				If ([Invoices:5]AMLrelationship:98="")  // not available in moneygram transaction result or in data passed to Profix web app
					[Invoices:5]AMLrelationship:98:=[WebEWires:149]toParty:8[Info_Relationship]
				End if 
				
				If ([Invoices:5]AMLCountryCode:87="")
					//[Invoices]AMLCountryCode:=mgCountryCode2CXR_CC($mg.result.destinationCountry)  // we use alpha2 codes, MoneyGram uses alpha3
					[Invoices:5]AMLCountryCode:87:=[WebEWires:149]toParty:8[Info_CountryCode]
				End if 
				
				If ([Invoices:5]SourceOfFund:68="")  // not available in MG transaction data
					[Invoices:5]SourceOfFund:68:=[WebEWires:149]AML_Info:9[AML_sourceOfFunds]
				End if 
				
				If ([Invoices:5]AMLPurposeOfTransaction:85="")  // not available in MG transaction
					[Invoices:5]AMLPurposeOfTransaction:85:=[WebEWires:149]AML_Info:9[AML_purposeOfTransaction]
				End if 
				
			Else 
				handlePaymentInInvoiceNew(->[AccountInOuts:37]; ->[AccountInOuts:37]InvoiceID:4; ->[AccountInOuts:37]isPaid:9; $isPaid; True:C214)
			End if 
			
		: ($vPaymentMethod=c_Items)
			handlePaymentInInvoiceNew(->[ItemInOuts:40]; ->[ItemInOuts:40]InvoiceID:4; ->[ItemInOuts:40]isSold:7; $isPaid; True:C214)
			
	End case 
	
	If (vAML_POT#"")
		[Invoices:5]AMLPurposeOfTransaction:85:=vAML_POT
	End if 
	If (vAML_SOF#"")
		[Invoices:5]SourceOfFund:68:=vAML_SOF
	End if 
	
	If (isOK)
		vecPaymentMethod{0}:=c_Cash
		vecPaymentMethod:=0
	End if 
	
	relateManyRegistersForInvoice
	GOTO OBJECT:C206(*; "vReceivedPaid")
	
End if 