//%attributes = {}
// setTxOutgoingWire($root;$transaction)
// Generate the tag <Transaction> for PTR Report

C_TEXT:C284($1; $root; $2; $transaction)
Case of 
	: (Count parameters:C259=2)
		$root:=$1
		$transaction:=$2
	Else 
End case 


C_DATE:C307($refDate)
C_REAL:C285($inverseRate)
C_TEXT:C284($goAMLDate; $tmp; $fromForeignCurrency; $to_party; $to_account)

C_TEXT:C284($currencyCodeLocal; $reason; $toForeignCurrency; $from_party)
C_TEXT:C284($txNode; $element; $t_from_my_client; $t_conductor; $from_account; $t_to)
C_TEXT:C284($rentityBranch; $entityReference; $submissionCode; $reportCode; $submissionDate; $txtNode; $toAccount)


$txNode:=<>Reports_PTR_DefTxTypeWiresOut
If ([Invoices:5]TransactionTypeID:91="")
	If ([Wires:8]isOutgoingWire:16)
		$txtNode:=<>Reports_PTR_DefTxTypeWiresOut
	Else 
		$txNode:=<>Reports_PTR_DefTxTypeWiresIn
	End if 
	$element:=GAML_CreateXMLNode($transaction; "transmode_code"; ->$txNode; True:C214)
Else 
	$element:=GAML_CreateXMLNode($transaction; "transmode_code"; ->$txNode; True:C214)
End if 

$tmp:=String:C10([Wires:8]AmountLocal:25; "###########0")
$element:=GAML_CreateXMLNode($transaction; "amount_local"; ->$tmp; True:C214)
//$element:=GAML_CreateXMLNode ($transaction;"amount_local";->[Wires]AmountLocal;True)

If ([Customers:3]AML_ignoreKYC:35=True:C214)  // Customer is not my client
	$t_from_my_client:=GAML_CreateXMLNode($transaction; "t_from")
Else 
	$t_from_my_client:=GAML_CreateXMLNode($transaction; "t_from_my_client")
End if 

If ([Invoices:5]fromMOP:97#"")
	
	If ([Invoices:5]fromMOP:97#<>Reports_PTR_OtherFundsCode)
		$element:=GAML_CreateXMLNode($t_from_my_client; "from_funds_code"; ->[Invoices:5]fromMOP:97; True:C214)
	Else 
		$element:=GAML_CreateXMLNode($t_from_my_client; "from_funds_code"; ->[Invoices:5]TransactionTypeID:91; True:C214)  // P: Other
		$element:=GAML_CreateXMLNode($t_from_my_client; "from_funds_comment"; ->[Wires:8]AML_SourceOfFunds:66; True:C214)
	End if 
	
Else 
	$element:=GAML_CreateXMLNode($t_from_my_client; "from_funds_code"; -><>Reports_PTR_DefTxFundTypeWOut; True:C214)
End if 

//$to_party:=GAML_CreateXMLNode ($t_from_my_client;"to_party")


READ ONLY:C145([WireTemplates:42])

QUERY:C277([WireTemplates:42]; [WireTemplates:42]WireTemplateID:1=[Wires:8]WireTemplateID:83)

//QUERY([WireTemplates];[WireTemplates]CustomerID=[Wires]CustomerID)
//QUERY SELECTION([WireTemplates];[WireTemplates]relationship="self")

// It is not necesary to ask for records in selection, GAML_CreateXMLNode will add MISSING values




If (False:C215)
	If ([Customers:3]isAccount:34=True:C214)
		READ ONLY:C145([WireTemplates:42])
		
		QUERY:C277([WireTemplates:42]; [WireTemplates:42]WireTemplateID:1=[Wires:8]WireTemplateID:83)
		
		//QUERY([WireTemplates];[WireTemplates]CustomerID=[Wires]CustomerID)
		//QUERY SELECTION([WireTemplates];[WireTemplates]relationship="self")
		
		// It is not necesary to ask for records in selection, GAML_CreateXMLNode will add MISSING values
		
		$from_account:=GAML_CreateXMLNode($t_from_my_client; "from_account")
		$element:=GAML_CreateXMLNode($from_account; "institution_name"; ->[WireTemplates:42]BankName:3; True:C214)
		
		If ([WireTemplates:42]SWIFT:8#"")
			$element:=GAML_CreateXMLNode($from_account; "swift"; ->[WireTemplates:42]SWIFT:8; True:C214)
		Else 
			$tmp:="N/A"
			$element:=GAML_CreateXMLNode($from_account; "swift"; ->$tmp; True:C214)
		End if 
		
		$tmp:="false"
		$element:=GAML_CreateXMLNode($from_account; "non_bank_institution"; ->$tmp; True:C214)
		
		If ([WireTemplates:42]BranchTransitNo:5#"")
			$element:=GAML_CreateXMLNode($from_account; "branch"; ->[WireTemplates:42]BranchTransitNo:5; True:C214)
		Else 
			
			$tmp:="N/A"
			$element:=GAML_CreateXMLNode($from_account; "branch"; ->$tmp; True:C214)
		End if 
		
		$tmp:=Replace string:C233([WireTemplates:42]AccountNo:6; "-"; "")
		$element:=GAML_CreateXMLNode($from_account; "account"; ->$tmp; True:C214)
		//$element:=GAML_CreateXMLNode ($from_account;"account";->[WireTemplates]AccountNo;True)
		
		$element:=GAML_CreateXMLNode($from_account; "currency_code"; ->[WireTemplates:42]Currency:36; True:C214)
		$element:=GAML_CreateXMLNode($from_account; "account_name"; ->[WireTemplates:42]BeneficiaryFullName:9; True:C214)
		
	Else 
		
		Case of 
			: ([Customers:3]isCompany:41=False:C215)  // Conductor is a Person
				$t_conductor:=GAML_CreateXMLNode($t_from_my_client; "from_person")
				GAML_NodeT_PersonFromCustomer($t_conductor)
				
			: ([Customers:3]isCompany:41=True:C214)  // Conductor is a Company
				
				$t_conductor:=GAML_CreateXMLNode($t_from_my_client; "from_entity")
				GAML_NodeT_PersonFromCustomer($t_conductor)
				
		End case 
		
	End if 
	
End if 



$t_to:=GAML_CreateXMLNode($transaction; "t_to")

$from_account:=GAML_CreateXMLNode($t_from_my_client; "from_account")
GAML_NodeT_AccountWires($from_account; "from")

If ([Wires:8]originatorCountryCode:84#"")
	$element:=GAML_CreateXMLNode($t_from_my_client; "from_country"; ->[Wires:8]originatorCountryCode:84; True:C214)
Else 
	$tmp:="NZ"
	$element:=GAML_CreateXMLNode($t_from_my_client; "from_country"; ->$tmp; True:C214)
End if 


If ([Wires:8]toMOP_Code:80#"")
	
	If ([Wires:8]toMOP_Code:80#<>Reports_PTR_OtherFundsCode)
		$element:=GAML_CreateXMLNode($t_to; "to_funds_code"; ->[Wires:8]toMOP_Code:80; True:C214)
	Else 
		$element:=GAML_CreateXMLNode($t_to; "to_funds_code"; ->[Wires:8]toMOP_Code:80; True:C214)  // P: Other
		$element:=GAML_CreateXMLNode($t_to; "to_funds_comment"; ->[Wires:8]AML_SourceOfFunds:66; True:C214)
	End if 
Else 
	$element:=GAML_CreateXMLNode($t_to; "to_funds_code"; -><>Reports_PTR_DefTxFundTypeWOut; True:C214)
End if 

setForeignCurrencySection($t_to; False:C215)  // is a WIRE

$to_account:=GAML_CreateXMLNode($t_to; "to_account")
GAML_NodeT_AccountWires($to_account; "to")

If ([Wires:8]BeneficiaryBankCountryCode:77#"")
	$element:=GAML_CreateXMLNode($t_to; "to_country"; ->[Wires:8]BeneficiaryBankCountryCode:77; True:C214)
Else 
	$tmp:=GAML_GetCountryCode([Wires:8]BeneficiaryBankCountry:6)
	$element:=GAML_CreateXMLNode($t_to; "to_country"; ->$tmp; True:C214)
End if 
