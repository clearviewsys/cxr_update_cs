//%attributes = {}
C_TEXT:C284($1; $root; $2; $transaction)

Case of 
	: (Count parameters:C259=2)
		$root:=$1
		$transaction:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_DATE:C307($refDate)
C_REAL:C285($inverseRate)
C_TEXT:C284($goAMLDate; $tmp)

C_TEXT:C284($currencyCodeLocal; $reason; $toForeignCurrency)
C_TEXT:C284($txNode; $element; $t_from_my_client; $t_conductor; $from_account; $t_to)
C_TEXT:C284($rentityBranch; $entityReference; $submissionCode; $reportCode; $submissionDate)
C_TEXT:C284(AML_EntityReference)

$rentityBranch:=[Branches:70]BranchName:2
$entityReference:=[Branches:70]BranchID:1+"-"+[Branches:70]BranchName:2

$submissionCode:=<>Reports_PTR_DefaultSubCode  // E-Electronic, M-Manually
$reportCode:="IFT"
$submissionDate:=FT_GetStringDate(Current date:C33(*); "-")+"T"+FT_GetStringTime(Current time:C178(*); ":")
$reason:="IFT greater than "+String:C10(<>THRESHOLDFORPTRTRANSFERS)+" "+<>baseCurrency
// [ServerPrefs];"Preferences"

// Generate the XML Header

$element:=GAML_CreateXMLNode($root; "rentity_id"; ->reportingEntityID)
$element:=GAML_CreateXMLNode($root; "submission_code"; ->$submissionCode)

$element:=GAML_CreateXMLNode($root; "report_code"; ->$reportCode)
$element:=GAML_CreateXMLNode($root; "entity_reference"; ->reportingEntityName)
// $element:=GAML_CreateXMLNode ($root;"entity_reference";->[Invoices]InvoiceID) // TODO: change to Invoice Number?
AML_EntityReference:=$entityReference
$element:=GAML_CreateXMLNode($root; "submission_date"; ->$submissionDate)
$element:=GAML_CreateXMLNode($root; "currency_code_local"; -><>baseCurrency)
GAML_SetReportingPerson($root)
$element:=GAML_CreateXMLNode($root; "reason"; ->$reason)

