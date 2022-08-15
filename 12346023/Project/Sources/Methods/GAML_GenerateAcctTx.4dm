//%attributes = {}
// ------------------------------------------------------------------------------
// Method: GAML_GenerateAcctTx
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
C_REAL:C285($exchangeR; $invRate)
C_TEXT:C284($to_account; $nodeRef; $dummy; $signatory; $t_entity; $t_person)


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


$t_from:=GAML_CreateXMLNode($transaction; "t_from_my_client")

$tmp:="E"  //E Bank draft
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
	$invRate:=calcSafeDivide(1; [Registers:10]OurRate:25)
	$element:=GAML_CreateXMLNode($fromForeignCurrency; "foreign_exchange_rate"; ->$invRate; True:C214)
	
End if 


$from_account:=GAML_CreateXMLNode($t_from; "from_account")

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
	GAML_NodeT_PersonFromCustomer($t_entity)
	
Else 
	$signatory:=GAML_CreateXMLNode($from_account; "signatory")
	
	//$dummy:="true"
	//$element:=GAML_CreateXMLNode ($signatory;"is_primary";->$dummy)
	
	$t_person:=GAML_CreateXMLNode($signatory; "t_person")
	GAML_NodeT_PersonFromCustomer($t_person)
End if 
$element:=GAML_CreateXMLNode($t_from; "from_country"; -><>CountryCode; True:C214)

$t_to:=GAML_CreateXMLNode($transaction; "t_to")

$tmp:="N"
$element:=GAML_CreateXMLNode($t_to; "to_funds_code"; ->$tmp; True:C214)

$to_account:=GAML_CreateXMLNode($t_to; "to_account")

READ ONLY:C145([AccountInOuts:37])
QUERY:C277([AccountInOuts:37]; [AccountInOuts:37]InvoiceID:4=[Invoices:5]InvoiceID:1)
//QUERY([AccountInOuts];[AccountInOuts]RegisterID="QSREG20087698")

QUERY:C277([WireTemplates:42]; [WireTemplates:42]WireTemplateID:1=[AccountInOuts:37]WireTemplateID:27)

C_OBJECT:C1216($wiretempl)
$wiretempl:=ds:C1482.WireTemplates.query("WireTemplateID = :1"; [AccountInOuts:37]WireTemplateID:27).first()
$tmp:=""

If ($wiretempl#Null:C1517)
	
	$tmp:=$wiretempl.BankName
	$element:=GAML_CreateXMLNode($to_account; "institution_name"; ->$tmp; True:C214)
	
	$tmp:=$wiretempl.SWIFT
	$element:=GAML_CreateXMLNode($to_account; "swift"; ->$tmp; True:C214)
	
	$tmp:=$wiretempl.AccountNo
	$element:=GAML_CreateXMLNode($to_account; "account"; ->$tmp; True:C214)
	
	$tmp:=$wiretempl.BeneficiaryFullName
	$element:=GAML_CreateXMLNode($to_account; "account_name"; ->$tmp; True:C214)
	
End if 

$signatory:=GAML_CreateXMLNode($to_account; "signatory")

$t_person:=GAML_CreateXMLNode($signatory; "t_person")
GAML_NodeT_PersonFromCustomer($t_person)

$tmp:=<>CountryCode
$element:=GAML_CreateXMLNode($t_to; "to_country"; ->$tmp; True:C214)

SET QUERY DESTINATION:C396(Into current selection:K19:1)
