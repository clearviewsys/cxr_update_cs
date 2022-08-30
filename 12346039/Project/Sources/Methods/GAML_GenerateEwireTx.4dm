//%attributes = {}
// ------------------------------------------------------------------------------
// Method: GAML_GenerateeWireTx
// Generate the XML Report for goAML when we have an Ewire
//
// Parameters: 
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 8/9/2017
// ------------------------------------------------------------------------------

C_TEXT:C284($1; $root)
C_TEXT:C284($2; $fileName; $goAMLDate; $3; $number)
C_TEXT:C284($rootRef; $root; $element; $transcation; $phones; $tmp)
C_TEXT:C284($t_from_my_client; $element; $fromForeignCurrency; $from_person; $t_to_my_client; $to_person; $from_account)
C_BLOB:C604($blob)
C_REAL:C285($exchangeR)


Case of 
	: (Count parameters:C259=3)
		$root:=$1
		$fileName:=$2
		$number:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
READ ONLY:C145([eWires:13])
QUERY:C277([eWires:13]; [eWires:13]InvoiceNumber:29=$number)

// ------------------------------------------------------------------------------------
// Create the Transactions report
// ------------------------------------------------------------------------------------
C_LONGINT:C283($maxTx)
C_TEXT:C284($element; $transaction; $t_from; $t_to; $to_account)
$maxTx:=Records in selection:C76([eWires:13])
C_LONGINT:C283($i)


For ($i; 1; $maxTx)
	
	$transaction:=GAML_CreateXMLNode($root; "transaction")
	READ ONLY:C145([Invoices:5])
	QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=[eWires:13]InvoiceNumber:29)
	
	READ ONLY:C145([Customers:3])
	QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[Invoices:5]CustomerID:2)
	
	READ ONLY:C145([Links:17])
	QUERY:C277([Links:17]; [Links:17]LinkID:1=[eWires:13]LinkID:8)
	
	READ ONLY:C145([Branches:70])
	QUERY:C277([Branches:70]; [Branches:70]BranchID:1=[Invoices:5]BranchID:53)
	$element:=GAML_CreateXMLNode($transaction; "transactionnumber"; ->[Invoices:5]InvoiceID:1)
	// transactionnumber must be the invoice Number not the ewire ID: Hash requirement.
	// TODO: Is it the same for Relianz?
	
	//$element:=GAML_CreateXMLNode ($transaction;"transactionnumber";->[eWires]eWireID;True)
	$tmp:=Replace string:C233([Branches:70]BranchName:2+", "+[Branches:70]Address:3+", "+[Branches:70]City:4; Char:C90(CR ASCII code:K15:14); "")
	If (([Branches:70]Address:3="") | ([Branches:70]City:4=""))
		$tmp:=Replace string:C233($tmp; ", "; "")
	End if 
	
	$tmp:=Replace string:C233($tmp; Char:C90(LF ASCII code:K15:11); "")
	
	$element:=GAML_CreateXMLNode($transaction; "transaction_location"; ->$tmp; True:C214)
	
	// Removed: Hash requirement.
	//$element:=GAML_CreateXMLNode ($transaction;"transaction_description";->[eWires]PurposeOfTransaction;False)
	
	If ([eWires:13]isSettled:23)
		$goAMLDate:=FT_GetStringDate([eWires:13]ReceiveDate:18; "-")+"T"+FT_GetStringTime([eWires:13]ReceiveTime:19; ":")
	Else 
		$goAMLDate:=FT_GetStringDate([eWires:13]SendDate:2; "-")+"T"+FT_GetStringTime([eWires:13]SendTime:3; ":")
	End if 
	
	$element:=GAML_CreateXMLNode($transaction; "date_transaction"; ->$goAMLDate; True:C214)
	
	//$element:=GAML_CreateXMLNode ($transaction;"teller";->[Invoices]CreatedByUserID)
	
	
	// Transaction Mode: How the transaction was conducted
	// BF-In-branch/Office - Denomination exchange,  BE-In-branch/Office-Currency exchange (default)
	If ([Invoices:5]TransactionTypeID:91="")
		$tmp:=<>Reports_PTR_TxModeEwires
		$element:=GAML_CreateXMLNode($transaction; "transmode_code"; ->$tmp; True:C214)
	Else 
		$element:=GAML_CreateXMLNode($transaction; "transmode_code"; ->[Invoices:5]TransactionTypeID:91; True:C214)  // changed by TB
		
	End if 
	
	If ([eWires:13]isPaymentSent:20)
		$tmp:=String:C10([eWires:13]amountLocal:45; "###########0.00")
		$element:=GAML_CreateXMLNode($transaction; "amount_local"; ->$tmp; True:C214)
		//$element:=GAML_CreateXMLNode ($transaction;"amount_local";->[eWires]amountLocal;True)
	Else 
		$tmp:=String:C10([eWires:13]FromAmount:13; "###########0.00")
		$tmp:=String:C10([eWires:13]FromAmount:13; "###########0")
		$element:=GAML_CreateXMLNode($transaction; "amount_local"; ->$tmp; True:C214)
		//$element:=GAML_CreateXMLNode ($transaction;"amount_local";->[eWires]FromAmount;True)
		
	End if 
	
	
	If ([eWires:13]isPaymentSent:20)  // Outgoing eWire
		$t_from:=GAML_CreateXMLNode($transaction; "t_from_my_client")
	Else 
		$t_from:=GAML_CreateXMLNode($transaction; "t_from")
	End if 
	
	
	// Hash requirement all Wires are "N": TODO:Validate with Relianz 
	$tmp:="N"
	$element:=GAML_CreateXMLNode($t_from; "from_funds_code"; ->$tmp; True:C214)
	
	If (<>Reports_PTR_OtherFundsCode=[eWires:13]fromMOP_Code:113)  // is 'P' 
		$element:=GAML_CreateXMLNode($t_from; "from_funds_comment"; ->[eWires:13]AMLsourceOfFunds:94; True:C214)
	End if 
	
	
	
	If ([eWires:13]isPaymentSent:20=False:C215)  // Incoming eWire
		
		$from_account:=GAML_CreateXMLNode($t_from; "from_account")
		GAML_NodeT_Account($from_account; "from")
		
	Else 
		
		$from_account:=GAML_CreateXMLNode($t_from; "from_account")
		GAML_NodeT_Account($from_account; "from")
		
	End if 
	
	
	
	
	$element:=GAML_CreateXMLNode($t_from; "from_country"; ->[eWires:13]fromCountryCode:111; True:C214)
	
	If ([eWires:13]isPaymentSent:20)  // Outgoing eWire
		$t_to:=GAML_CreateXMLNode($transaction; "t_to")
	Else 
		$t_to:=GAML_CreateXMLNode($transaction; "t_to_my_client")
	End if 
	
	
	// TODO: Validate with relianz. Hash Requirement
	$tmp:="N"
	$element:=GAML_CreateXMLNode($t_to; "to_funds_code"; ->$tmp; True:C214)
	
	setForeignCurrencySection($t_to; True:C214)
	
	$to_account:=GAML_CreateXMLNode($t_to; "to_account")
	GAML_NodeT_Account($to_account; "to")
	
	$element:=GAML_CreateXMLNode($t_to; "to_country"; ->[eWires:13]toCountryCode:112; True:C214)
	
	
	NEXT RECORD:C51([eWires:13])
	
End for   // Loop Transactions


