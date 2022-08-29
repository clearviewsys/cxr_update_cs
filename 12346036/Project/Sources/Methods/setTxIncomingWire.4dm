//%attributes = {}

// setTxIncomingWire($root;$transaction)
// Generate the tag <Transaction> for PTR Report (Inocming Wire)

C_TEXT:C284($1; $root; $2; $transaction)
Case of 
	: (Count parameters:C259=2)
		$root:=$1
		$transaction:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 



C_DATE:C307($refDate)
C_TEXT:C284($inverseRate)
C_TEXT:C284($goAMLDate; $tmp; $dummy)

C_TEXT:C284($currencyCodeLocal; $reason; $toForeignCurrency)
C_TEXT:C284($txNode; $element; $t_from; $t_conductor; $from_account; $t_to)
C_TEXT:C284($rentityBranch; $entityReference; $submissionCode; $reportCode; $submissionDate)
C_TEXT:C284($t_to_myclient; $element; $to_account; $toAccount)

$dummy:="Unkown"

If ([Invoices:5]TransactionTypeID:91="")
	$element:=GAML_CreateXMLNode($transaction; "transmode_code"; -><>Reports_PTR_DefTxTypeWiresIn; True:C214)
Else 
	$element:=GAML_CreateXMLNode($transaction; "transmode_code"; ->[Invoices:5]TransactionTypeID:91)  // changed by TB
End if 
$tmp:=String:C10([Wires:8]AmountLocal:25; "###########0.00")
$element:=GAML_CreateXMLNode($transaction; "amount_local"; ->$tmp)
//$element:=GAML_CreateXMLNode ($transaction;"amount_local";->[Wires]AmountLocal)

$t_from:=GAML_CreateXMLNode($transaction; "t_from")

If ([Invoices:5]fromMOP:97#"")
	
	If ([Invoices:5]fromMOP:97#<>Reports_PTR_OtherFundsCode)
		$element:=GAML_CreateXMLNode($t_from; "from_funds_code"; ->[Invoices:5]fromMOP:97; True:C214)
	Else 
		$element:=GAML_CreateXMLNode($t_from; "from_funds_code"; ->[Invoices:5]TransactionTypeID:91; True:C214)  // P: Other
		$element:=GAML_CreateXMLNode($t_from; "from_funds_comment"; ->[Wires:8]AML_SourceOfFunds:66; True:C214)
	End if 
	
Else 
	$element:=GAML_CreateXMLNode($t_from; "from_funds_code"; -><>Reports_PTR_DefTxFundTypeWOut; True:C214)
End if 

If ([Invoices:5]fromCurrency:3#[Invoices:5]toCurrency:8)
	
	// Foreign Currency
	$toForeignCurrency:=GAML_CreateXMLNode($t_to; "to_foreign_currency")
	$element:=GAML_CreateXMLNode($toForeignCurrency; "foreign_currency_code"; ->[Wires:8]Currency:15; True:C214)
	
	$tmp:=String:C10([Wires:8]Amount:14; "###########0.00")
	$element:=GAML_CreateXMLNode($toForeignCurrency; "foreign_amount"; ->$tmp; True:C214)
	//$element:=GAML_CreateXMLNode ($toForeignCurrency;"foreign_amount";->[Wires]Amount;True)
	
	$inverseRate:=String:C10(Trunc:C95(calcSafeDivide(1; [Registers:10]OurRate:25); 4))
	$element:=GAML_CreateXMLNode($toForeignCurrency; "foreign_exchange_rate"; ->$inverseRate; True:C214)
End if 

$from_account:=GAML_CreateXMLNode($t_from; "from_account")
$element:=GAML_CreateXMLNode($from_account; "institution_name"; ->[Wires:8]OriginatingBankName:43)  // TODO: NOT mandatory
$element:=GAML_CreateXMLNode($from_account; "swift"; ->$dummy)  // TODO: mandatory Create Field
$element:=GAML_CreateXMLNode($from_account; "account"; ->$dummy)  // TODO: mandatory create field
$element:=GAML_CreateXMLNode($from_account; "account_name"; ->[Wires:8]OriginatorFullName:34)


// TODO: If originatorIsCompany report the name. Create Field 

//If ([Wires]originatorIsCompany)
//
//$t_entity:=GAML_CreateXMLNode ($from_account;"t_entity")
//$element:=GAML_CreateXMLNode ($t_entity;"name";[Wires]OriginatorFullName;true)  // TODO: mandatory
//$element:=GAML_CreateXMLNode ($from_account;"status_code")  // Optional
//End if 


If ([Wires:8]OriginatingBankCountryCode:85#"")
	$element:=GAML_CreateXMLNode($t_from; "from_country"; ->[Wires:8]OriginatingBankCountryCode:85; True:C214)
Else 
	$tmp:=GAML_GetCountryCode([Wires:8]OriginatingBankCountry:46)
	$element:=GAML_CreateXMLNode($t_from; "from_country"; ->$tmp; True:C214)
End if 



$t_to_myclient:=GAML_CreateXMLNode($transaction; "t_to_myclient")

$tmp:="N"  // TODO: get it from [wires]MOP create Field
If ($tmp#<>Reports_PTR_OtherFundsCode)
	$element:=GAML_CreateXMLNode($t_to_myclient; "to_funds_code"; -><>Reports_PTR_DefTxFundTypeWOut)
Else 
	$element:=GAML_CreateXMLNode($t_to_myclient; "to_funds_code"; ->$tmp)  // P: Other
	$element:=GAML_CreateXMLNode($t_to_myclient; "to_funds_comment"; ->[Wires:8]AML_SourceOfFunds:66)
End if 


$to_account:=GAML_CreateXMLNode($t_to_myclient; "to_account")
$element:=GAML_CreateXMLNode($to_account; "institution_name"; ->[Wires:8]BeneficiaryBankName:3; True:C214)
If ([Wires:8]BeneficiarySWIFT:28#"")
	$element:=GAML_CreateXMLNode($to_account; "swift"; ->[Wires:8]BeneficiarySWIFT:28; True:C214)
Else 
	If ([Wires:8]BeneficiaryRoutingCode:27#"")
		$element:=GAML_CreateXMLNode($toAccount; "swift"; ->[Wires:8]BeneficiaryRoutingCode:27; True:C214)
	Else 
		$tmp:="N/A"
		$element:=GAML_CreateXMLNode($toAccount; "swift"; ->$tmp; True:C214)
	End if 
End if 

$tmp:=Replace string:C233([Wires:8]BeneficiaryAccountNo:9; "-"; "")
$element:=GAML_CreateXMLNode($to_account; "account"; ->$tmp; True:C214)
//$element:=GAML_CreateXMLNode ($to_account;"account";->[Wires]BeneficiaryAccountNo;True)

$element:=GAML_CreateXMLNode($to_account; "account_name"; ->[Wires:8]BeneficiaryFullName:10)

If ([Wires:8]BeneficiaryBankCountryCode:77#"")
	$element:=GAML_CreateXMLNode($t_to; "to_country"; ->[Wires:8]BeneficiaryBankCountryCode:77; True:C214)
Else 
	$tmp:=GAML_GetCountryCode([Wires:8]BeneficiaryBankCountry:6)
	$element:=GAML_CreateXMLNode($t_to; "to_country"; ->$tmp; True:C214)
End if 






