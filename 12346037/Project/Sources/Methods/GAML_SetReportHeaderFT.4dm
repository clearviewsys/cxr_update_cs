//%attributes = {}
// ------------------------------------------------------------------------------
// Method: GAML_SetReportHeaderFT
// Generate the Report XML Header
// ------------------------------------------------------------------------------


C_TEXT:C284($1; $root)
C_TEXT:C284($2; $reportCode)

C_TEXT:C284($element; $firstName; $lastName; $otherName; $tmp)
C_TEXT:C284($rentityID; $rentityBranch; $submissionCode; $entityReference; $submissionDate; $currencyCodeLocal)
C_TEXT:C284(AML_EntityReference)

$rentityBranch:=[Branches:70]BranchName:2
$entityReference:=[Branches:70]BranchID:1+"-"+[Branches:70]BranchName:2
$submissionDate:=FT_GetStringDate(Current date:C33(*); "-")+"T"+FT_GetStringTime(Current time:C178(*); ":")
$currencyCodeLocal:=<>baseCurrency
$submissionCode:=<>Reports_PTR_DefaultSubCode  // E-Electronic, M-Manually
$rentityID:=reportingEntityID
AML_EntityReference:=$entityReference
Case of 
		
	: (Count parameters:C259=1)
		
		$root:=$1
		
		
		// Report codes: 
		// LCT-Cash Transaction Report, IFT-International Found Transfers
		// CTR-Cash Transaction Report, STR-Suspicious Transaction Report
		
		$reportCode:=<>Reports_PTR_ReportCodeFT
		
		
	: (Count parameters:C259=2)
		
		$root:=$1
		$reportCode:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$element:=GAML_CreateXMLNode($root; "rentity_id"; ->$rentityID)

If (<>Reports_PTR_Version="1.4")
	// TODO: Verify with Relianz
	//$element:=GAML_CreateXMLNode ($root;"rentity_branch";->$rentityBranch)
End if 
$element:=GAML_CreateXMLNode($root; "rentity_branch"; ->reportingBranchName)
$element:=GAML_CreateXMLNode($root; "submission_code"; ->$submissionCode)

$element:=GAML_CreateXMLNode($root; "report_code"; ->$reportCode)
$element:=GAML_CreateXMLNode($root; "entity_reference"; ->$rentityID)
$element:=GAML_CreateXMLNode($root; "submission_date"; ->$submissionDate)

$element:=GAML_CreateXMLNode($root; "currency_code_local"; ->$currencyCodeLocal)

GAML_SetReportingPerson($root)
$tmp:="N/A"
$element:=GAML_CreateXMLNode($root; "reason"; ->$tmp)
$element:=GAML_CreateXMLNode($root; "action"; ->$tmp)
// Primary reporting entity supervisor, indicate either: "
// 1. RBNZ(Reserve Bank of New Zealand)
// 2. DIA(Department of Internal Affairs)
// 3. FMA(Financial Markets Authority
// For those reporting entities with more than one supervisor(e.g. subsidiary entities)
// the primary supervisor should be included. Multiple supervisors must not be provided

$tmp:="FMA"
// TODO: Validation Error
//$element:=GAML_CreateXMLNode ($root;"indicator";->$tmp)

