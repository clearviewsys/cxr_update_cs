//%attributes = {}
// ------------------------------------------------------------------------------
// Method: GAML_SetReportingPerson
// Generate the XML for Reporting Person
// ------------------------------------------------------------------------------



C_TEXT:C284($1; $rootRef; $element; $firstName; $lastName; $otherName)

Case of 
	: (Count parameters:C259=1)
		
		$rootRef:=$1
		$firstName:=contactGivenName
		$lastName:=contactSurName
		$otherName:=contactOtherName
		
	: (Count parameters:C259=3)
		
		$rootRef:=$1
		$firstName:=$2
		$lastName:=$3
		$otherName:=$4
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

//<reporting_person>
//<title>Mr</title>
//<first_name>Test testtestsetsest</first_name>
//<last_name>test</last_name>
//<phones>
//<phone>
//<tph_contact_type>C</tph_contact_type>
//<tph_communication_type>B</tph_communication_type>
//<tph_number>21454541</tph_number>
//</phone>
//</phones>
//<addresses>
//<address>
//<address_type>C</address_type>
//<address>1234 TEST STREET</address>
//<city>Wellington</city>
//<zip>3213</zip>
//<country_code>NZ</country_code>
//<state>Thorndon</state>
//</address>
//</addresses>
//<email>doesn_exist@dontbother.com</email>
//<occupation>Bank</occupation>
//</reporting_person>

C_TEXT:C284($reportingPerson)

$reportingPerson:=GAML_CreateXMLNode($rootRef; "reporting_person")
$element:=GAML_CreateXMLNode($reportingPerson; "first_name"; ->$firstName)
$element:=GAML_CreateXMLNode($reportingPerson; "middle_name"; ->$otherName)
$element:=GAML_CreateXMLNode($reportingPerson; "last_name"; ->$lastName)




