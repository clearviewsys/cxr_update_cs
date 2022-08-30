//%attributes = {}
// ------------------------------------------------------------------------------
// Method: GAML_Generate_LCT_Report
// Generate the XML Report for goAML
//
// Parameters: 
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 8/9/2017
// ------------------------------------------------------------------------------
C_TEXT:C284($1; $fileName; $goAMLDate)
C_DATE:C307($2; $refDate)

ARRAY TEXT:C222($arrKeys; 0)
ARRAY TEXT:C222($arrValues; 0)
C_TEXT:C284($rootRef; $root; $element; $transcation; $phones; $tmp)
C_TEXT:C284($from_account; $t_entity; $signatory; $t_person; $t_to; $to_account)

Case of 
	: (Count parameters:C259=2)
		$fileName:=$1
		$refDate:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// Get the config information from the goaml.ini saved in the active 4D Database Folder
//GAML_GetEntityAndContactInfo 

// Generate the XML Header
$root:=DOM Create XML Ref:C861("report")

GAML_SetReportHeader($root; <>Reports_PTR_ReportCodeLCT)

//GAML_SetReportingPerson ($root)
//GAML_SetLocation ($root)


// ------------------------------------------------------------------------------------
// Create the report part
// ------------------------------------------------------------------------------------
C_LONGINT:C283($maxTx; $i)
C_TEXT:C284($transaction; $tmp)
C_TEXT:C284($t_from_my_client; $element; $fromForeignCurrency; $from_person; $t_to_my_client; $to_person; $toForeignCurrency; $dummy)
C_BLOB:C604($blob)



$maxTx:=Size of array:C274(arrFTCustomerId)

For ($i; 1; $maxTx)
	
	$transaction:=GAML_CreateXMLNode($root; "transaction")
	READ ONLY:C145([Invoices:5])
	QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=arrFTInvoiceNumber{$i})
	
	READ ONLY:C145([ThirdParties:101])
	QUERY:C277([ThirdParties:101]; [ThirdParties:101]InvoiceID:30=arrFTInvoiceNumber{$i})
	
	READ ONLY:C145([Customers:3])
	QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[Invoices:5]CustomerID:2)
	
	READ ONLY:C145([Registers:10])
	QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=arrFTRegisterID{$i})
	
	READ ONLY:C145([Branches:70])
	QUERY:C277([Branches:70]; [Branches:70]BranchID:1=[Invoices:5]BranchID:53)
	
	//$element:=GAML_CreateXMLNode ($transaction;"transactionnumber";->arrFTInvoiceNumber{$i})
	$element:=GAML_CreateXMLNode($transaction; "transactionnumber"; ->[Invoices:5]InvoiceID:1; True:C214)
	//$element:=GAML_CreateXMLNode ($transaction;"Internal_ref_number";->arrFTRegisterID{$i})
	
	$tmp:=getTransactionLocation
	$element:=GAML_CreateXMLNode($transaction; "transaction_location"; ->$tmp; True:C214)
	
	$element:=GAML_CreateXMLNode($transaction; "transaction_description"; ->[Invoices:5]AMLPurposeOfTransaction:85)
	
	$goAMLDate:=FT_GetStringDate([Invoices:5]CreationDate:13; "-")+"T"+FT_GetStringTime([Invoices:5]CreationTime:14; ":")
	$element:=GAML_CreateXMLNode($transaction; "date_transaction"; ->$goAMLDate; True:C214)
	
	If ([Invoices:5]TransactionTypeID:91="")
		$tmp:=<>Reports_PTR_LCT_DefaultTxType
		$element:=GAML_CreateXMLNode($transaction; "transmode_code"; ->$tmp; True:C214)
	Else 
		$element:=GAML_CreateXMLNode($transaction; "transmode_code"; ->[Invoices:5]TransactionTypeID:91; True:C214)
	End if 
	$tmp:=String:C10(arrFTTxAmount{$i}; "###########0.00")
	$element:=GAML_CreateXMLNode($transaction; "amount_local"; ->$tmp; True:C214)
	//$element:=GAML_CreateXMLNode ($transaction;"amount_local";->arrFTTxAmount{$i};True)
	
	// -----------------------------------------------------------------------------------------------------------------
	// Specifies where the money came from. Node XML: t_from_my_client
	// -----------------------------------------------------------------------------------------------------------------
	
	$t_from_my_client:=GAML_CreateXMLNode($transaction; "t_from_my_client")
	
	// Get source of founds
	Case of 
			
		: (Undefined:C82([Invoices:5]fromMOP:97))
			$tmp:=<>Reports_PTR_LCT_FromFoundsDef
			$element:=GAML_CreateXMLNode($t_from_my_client; "from_funds_code"; ->$tmp; True:C214)  // Normally  D: Cash
			
		: (<>Reports_PTR_OtherFundsCode=[Invoices:5]fromMOP:97)  // is 'P' 
			$element:=GAML_CreateXMLNode($t_from_my_client; "from_funds_comment"; ->[Invoices:5]SourceOfFund:68; True:C214)
			
		: ([Invoices:5]fromMOP:97="")  // Other
			$tmp:=<>Reports_PTR_LCT_FromFoundsDef
			$element:=GAML_CreateXMLNode($t_from_my_client; "from_funds_code"; ->$tmp; True:C214)  // Normally  D: Cash
			
	End case 
	
	$from_account:=GAML_CreateXMLNode($t_from_my_client; "from_account")
	
	$element:=GAML_CreateXMLNode($from_account; "institution_name"; ->reportingEntityName; True:C214)
	$element:=GAML_CreateXMLNode($from_account; "institution_code"; ->reportingEntityID; True:C214)
	
	$tmp:="true"
	$element:=GAML_CreateXMLNode($from_account; "non_bank_institution"; ->$tmp; True:C214)
	
	//$dummy:=getKeyValue ("nzptr.NZ.branch.account.name";"Manukau, Auckland")
	$tmp:=[Branches:70]BranchName:2+", "+[Branches:70]City:4
	$element:=GAML_CreateXMLNode($from_account; "branch"; ->$tmp; True:C214)
	
	$element:=GAML_CreateXMLNode($from_account; "account"; ->[Customers:3]CustomerID:1; True:C214)
	$element:=GAML_CreateXMLNode($from_account; "account_name"; ->[Customers:3]FullName:40; True:C214)
	
	
	If ([Customers:3]isCompany:41)
		$t_entity:=GAML_CreateXMLNode($from_account; "t_entity")
	Else 
		$signatory:=GAML_CreateXMLNode($from_account; "signatory")
		
		//$dummy:="true"
		//$element:=GAML_CreateXMLNode ($signatory;"is_primary";->$dummy)
		
		$t_person:=GAML_CreateXMLNode($signatory; "t_person")
	End if 
	
	GAML_NodeT_PersonFromCustomer($t_person)
	
	
	$element:=GAML_CreateXMLNode($t_from_my_client; "from_country"; -><>CountryCode; True:C214)
	
	
	$t_to:=GAML_CreateXMLNode($transaction; "t_to")
	$element:=GAML_CreateXMLNode($t_to; "to_funds_code"; ->[Registers:10]Currency:19; True:C214)
	
	$toForeignCurrency:=GAML_CreateXMLNode($t_to; "to_foreign_currency")
	
	$element:=GAML_CreateXMLNode($fromForeignCurrency; "foreign_currency_code"; ->[Registers:10]Currency:19; True:C214)
	
	$tmp:=String:C10([Registers:10]Debit:8; "###########0.00")
	$element:=GAML_CreateXMLNode($fromForeignCurrency; "foreign_amount"; ->$tmp; True:C214)
	//$element:=GAML_CreateXMLNode ($fromForeignCurrency;"foreign_amount";->[Registers]Debit;True)
	
	C_REAL:C285($exchangeR)
	
	$exchangeR:=Trunc:C95(calcSafeDivide(1; [Registers:10]OurRate:25); 4)
	$element:=GAML_CreateXMLNode($fromForeignCurrency; "foreign_exchange_rate"; ->$exchangeR; True:C214)
	
	
	
	Case of 
		: ([Registers:10]InternalTableNumber:17=Table:C252(->[Wires:8]))
			
			READ ONLY:C145([Wires:8])
			QUERY:C277([Wires:8]; [Wires:8]CXR_RegisterID:13=[Registers:10]RegisterID:1)
			
			If ([Wires:8]isOutgoingWire:16)
				$to_account:=GAML_CreateXMLNode($t_to; "to_account")
				$element:=GAML_CreateXMLNode($to_account; "institution_name"; ->[Wires:8]BeneficiaryBankName:3; True:C214)
				$element:=GAML_CreateXMLNode($to_account; "swift"; ->[Wires:8]BeneficiarySWIFT:28; True:C214)
				
				$dummy:="false"
				$element:=GAML_CreateXMLNode($to_account; "non_bank_institution"; ->$dummy; True:C214)
				
				$tmp:=Replace string:C233([Wires:8]BeneficiaryAccountNo:9; "-"; "")
				$element:=GAML_CreateXMLNode($to_account; "account"; ->$tmp; True:C214)
				$element:=GAML_CreateXMLNode($to_account; "account_name"; ->[Wires:8]BeneficiaryFullName:10; True:C214)
			Else 
				// Tx Does not exist
			End if 
			
			
		: ([Registers:10]InternalTableNumber:17=Table:C252(->[eWires:13]))
			
			$to_account:=GAML_CreateXMLNode($t_to; "to_account")
			SetToAccountSection($to_account)
			
			
	End case 
	
	
	
	
	If (False:C215)
		
		
		If ([Invoices:5]fromCurrency:3#<>BASECURRENCY)
			// Foreign Currency
			$fromForeignCurrency:=GAML_CreateXMLNode($t_from_my_client; "from_foreign_currency")
			$element:=GAML_CreateXMLNode($fromForeignCurrency; "foreign_currency_code"; ->[Registers:10]Currency:19; True:C214)
			
			$tmp:=String:C10([Registers:10]Debit:8; "###########0.00")
			$element:=GAML_CreateXMLNode($fromForeignCurrency; "foreign_amount"; ->$tmp; True:C214)
			//$element:=GAML_CreateXMLNode ($fromForeignCurrency;"foreign_amount";->[Registers]Debit;True)
			
			$element:=GAML_CreateXMLNode($fromForeignCurrency; "foreign_exchange_rate"; ->[Registers:10]OurRate:25; True:C214)
		End if 
		
		
		$from_person:=GAML_CreateXMLNode($t_from_my_client; "from_person")  // The person performing the transaction: Optional
		GAML_NodeT_PersonFromCustomer($from_person)  // Creates a $t_person node into a $t_conductor node 
		$tmp:=<>CountryCode
		$element:=GAML_CreateXMLNode($t_from_my_client; "from_country"; ->$tmp; True:C214)
		
		
		$t_to_my_client:=GAML_CreateXMLNode($transaction; "t_to_my_client")
		
		
		// Set destination of founds
		$tmp:=<>Reports_PTR_LCT_ToFoundsDefault
		$element:=GAML_CreateXMLNode($t_to_my_client; "to_funds_code"; ->$tmp)  //Normally  D: Cash
		
		
		$to_person:=GAML_CreateXMLNode($t_to_my_client; "to_person")
		GAML_NodeT_PersonFromCustomer($to_person)
		
		$tmp:=<>CountryCode
		$element:=GAML_CreateXMLNode($t_to_my_client; "to_country"; ->$tmp; True:C214)
	End if 
	
	
	
	If (operationMode=0)  // Production  Mode?
		GAML_SaveAMLReport("LCT")  // Send report Type
		
		
		READ WRITE:C146([Registers:10])
		QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=arrFTRegisterID{$i})
		If (Records in selection:C76([Registers:10])=1)
			
			[Registers:10]isExported:44:=True:C214
			SAVE RECORD:C53([Registers:10])
		End if 
	End if 
	
	
	
End for   // Loop Transactions

DOM EXPORT TO FILE:C862($root; $fileName)
DOM CLOSE XML:C722($root)

REDUCE SELECTION:C351([Invoices:5]; 0)
REDUCE SELECTION:C351([Customers:3]; 0)
REDUCE SELECTION:C351([Registers:10]; 0)

generatedFiles:=generatedFiles+"\n"+$fileName

DOCUMENT TO BLOB:C525($fileName; $blob)
xmlFile:=BLOB to text:C555($blob; UTF8 text without length:K22:17)

If (hasInvalidTags($fileName))
	myAlert("The File "+$fileName+CRLF+"Has invalid values in some tags. The file cannot be manually submitted to the GoAML Platform. Please review!")
End if 





