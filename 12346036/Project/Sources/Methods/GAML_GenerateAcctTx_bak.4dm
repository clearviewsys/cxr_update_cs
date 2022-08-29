//%attributes = {}
// ------------------------------------------------------------------------------
// Method: GAML_GenerateCashTx
// Generate the XML Report for goAML when we have a single Cash Tx
//
// Parameters: 
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 12/05/2020
// ------------------------------------------------------------------------------

C_TEXT:C284($1; $root)
C_TEXT:C284($2; $fileName; $goAMLDate; $3; $number)
C_TEXT:C284($rootRef; $root; $element; $transcation; $phones; $tmp)
C_TEXT:C284($transaction; $t_conductor; $t_from; $t_to; $to_entity; $t_from_my_client; $element; $fromForeignCurrency; $from_person; $t_to_my_client; $to_person; $from_account)
C_BLOB:C604($blob)
C_REAL:C285($exchangeR)
C_TEXT:C284($to_account; $nodeRef; $dummy; $signatory)


Case of 
		
	: (Count parameters:C259=2)
		$root:=$1
		$fileName:=$2
		$number:=[Invoices:5]InvoiceID:1
		
	: (Count parameters:C259=3)
		$root:=$1
		$fileName:=$2
		$number:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

SET QUERY DESTINATION:C396(Into named selection:K19:3; "tmpCash")
QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=$number)

$transaction:=GAML_CreateXMLNode($root; "transaction")
setTxHeaderCash($transaction)


$tmp:=String:C10([Registers:10]DebitLocal:23; "###########0.00")
$element:=GAML_CreateXMLNode($transaction; "amount_local"; ->$tmp; True:C214)



Case of 
	: ([Customers:3]isCompany:41=False:C215)  // Conductor is a Person
		$t_from:=GAML_CreateXMLNode($transaction; "t_from")
		$tmp:="D"
		$element:=GAML_CreateXMLNode($t_from; "from_funds_code"; ->$tmp; True:C214)
		
		
		
		//----------------------------------------------------------
		// Foreign Currency
		//----------------------------------------------------------
		If ([Registers:10]Currency:19#<>baseCurrency)
			
			$fromForeignCurrency:=GAML_CreateXMLNode($t_from; "from_foreign_currency")
			$element:=GAML_CreateXMLNode($fromForeignCurrency; "foreign_currency_code"; ->[Registers:10]Currency:19; True:C214)
			
			$tmp:=String:C10([Registers:10]Debit:8; "###########0.00")
			$element:=GAML_CreateXMLNode($fromForeignCurrency; "foreign_amount"; ->$tmp; True:C214)
			//$element:=GAML_CreateXMLNode ($fromForeignCurrency;"foreign_amount";->[Registers]Debit;True)
			
			$element:=GAML_CreateXMLNode($fromForeignCurrency; "foreign_exchange_rate"; ->[Registers:10]OurRate:25; True:C214)
			
		End if 
		
		$from_person:=GAML_CreateXMLNode($t_from; "from_person")
		$t_conductor:=$from_person
		
		GAML_NodeT_PersonFromCustomer($t_conductor)
		$element:=GAML_CreateXMLNode($t_from; "from_country"; -><>CountryCode; True:C214)
		
	: ([Customers:3]isCompany:41=True:C214)  // Conductor is a Company
		
		$t_from:=GAML_CreateXMLNode($transaction; "t_from")
		
		$tmp:="D"
		$element:=GAML_CreateXMLNode($t_from; "from_funds_code"; ->$tmp; True:C214)
		
		$t_conductor:=GAML_CreateXMLNode($t_from; "from_entity")
		GAML_NodeT_PersonFromCustomer($t_conductor)
		
		$element:=GAML_CreateXMLNode($t_from; "from_country"; -><>CountryCode; True:C214)
		
End case 

$t_to:=GAML_CreateXMLNode($transaction; "t_to_my_client")

$tmp:="N"
$element:=GAML_CreateXMLNode($t_to; "to_funds_code"; ->$tmp; True:C214)

$to_account:=GAML_CreateXMLNode($t_to; "to_account")

//$signatory:=GAML_CreateXMLNode ($nodeRef;"signatory")
If ([Customers:3]isCompany:41)
	$t_to:=GAML_CreateXMLNode($to_account; "t_entity")
Else 
	$signatory:=GAML_CreateXMLNode($to_account; "signatory")
	
	$dummy:="true"
	$element:=GAML_CreateXMLNode($to_account; "is_primary"; ->$dummy)
	
	$t_to:=GAML_CreateXMLNode($signatory; "t_person")
End if 

GAML_NodeT_PersonFromCustomer($t_to)

$tmp:=<>CountryCode
$element:=GAML_CreateXMLNode($t_to; "to_country"; ->$tmp; True:C214)


SET QUERY DESTINATION:C396(Into current selection:K19:1)
