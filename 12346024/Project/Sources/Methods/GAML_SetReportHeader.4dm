//%attributes = {}
// ------------------------------------------------------------------------------
// Method: GAML_SetReportHeader
// Generate the Report XML Header
// ------------------------------------------------------------------------------


C_TEXT:C284($1; $root)
C_TEXT:C284($2; $reportCode)

C_TEXT:C284(AML_EntityReference)
C_TEXT:C284($element; $firstName; $lastName; $otherName; $tmp)
C_TEXT:C284($rentityID; $rentityBranch; $submissionCode; $entityReference; $submissionDate; $currencyCodeLocal)
C_LONGINT:C283($yy; $mm; $dd)



$rentityBranch:=reportingBranchName
//$entityReference:=[Branches]BranchID+"-"+[Branches]BranchName

$submissionDate:=FT_GetStringDate(Current date:C33(*); "-")+"T"+FT_GetStringTime(Current time:C178(*); ":")
$entityReference:=Replace string:C233($submissionDate; "-"; "")
$entityReference:=Replace string:C233($entityReference; ":"; "")+"LCT"
AML_EntityReference:=$entityReference
$currencyCodeLocal:=<>baseCurrency
$submissionCode:=<>Reports_PTR_DefaultSubCode  // E-Electronic, M-Manually
$rentityID:=reportingEntityID

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
	//$element:=GAML_CreateXMLNode ($root;"rentity_branch";->$rentityBranch)
End if 
$element:=GAML_CreateXMLNode($root; "submission_code"; ->$submissionCode)

$element:=GAML_CreateXMLNode($root; "report_code"; ->$reportCode)
$element:=GAML_CreateXMLNode($root; "entity_reference"; ->$entityReference)
$element:=GAML_CreateXMLNode($root; "submission_date"; ->$submissionDate)

$element:=GAML_CreateXMLNode($root; "currency_code_local"; ->$currencyCodeLocal)

C_TEXT:C284($reporting_person)
$reporting_person:=GAML_CreateXMLNode($root; "reporting_person")

//$tmp:=getKeyValue ("GAML.reporting.person.title";"Mr")
$tmp:=contactTitle
$element:=GAML_CreateXMLNode($reporting_person; "title"; ->$tmp)

$element:=GAML_CreateXMLNode($reporting_person; "first_name"; ->contactGivenName)
$element:=GAML_CreateXMLNode($reporting_person; "last_name"; ->contactSurname)

//$tmp:=getKeyValue ("GAML.reporting.person.nationality";"LK")
$tmp:=contactNationality
$element:=GAML_CreateXMLNode($reporting_person; "nationality1"; ->$tmp)

//$tmp:=getKeyValue ("GAML.reporting.person.email";"it@lotusfx.com")

$tmp:=contactEmail
$element:=GAML_CreateXMLNode($reporting_person; "email"; ->$tmp)

//$tmp:=getKeyValue ("GAML.reporting.person.occupation";"IT Manager")
$tmp:=contactOccupation
$element:=GAML_CreateXMLNode($reporting_person; "occupation"; ->$tmp)

$tmp:="n/a"
$element:=GAML_CreateXMLNode($root; "reason"; ->$tmp)
$element:=GAML_CreateXMLNode($root; "action"; ->$tmp)

// Primary reporting entity supervisor, indicate either: "
// 1. RBNZ(Reserve Bank of New Zealand)
// 2. DIA(Department of Internal Affairs)
// 3. FMA(Financial Markets Authority
// For those reporting entities with more than one supervisor(e.g. subsidiary entities)
// the primary supervisor should be included. Multiple supervisors must not be provided

$tmp:="DIA"
// TODO: Validation Error
//$element:=GAML_CreateXMLNode ($root;"indicator";->$tmp)

