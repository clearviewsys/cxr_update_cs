//%attributes = {}
// FT_GeneratePart_F1_FromCustomer
// Part F1: Information about the entity on whose behalf the transaction was conduct(if applicable)

C_TEXT:C284($1; $fileName)
C_TEXT:C284($2; $partId)

Case of 
	: (Count parameters:C259=1)
		$fileName:=$1
		$partId:="F1"
	: (Count parameters:C259=2)
		$fileName:=$1
		$partId:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// --------------------------------------------------------------------------------------------------------------------
// Part F: Information about the entity on whose behalf the transaction was conduct(if applicable)
// This part only applies if the disposition was conducted on behalf of a third par(field B13)has to be “E”.
// --------------------------------------------------------------------------------------------------------------------

C_LONGINT:C283($partSeqNum; $i)
C_TEXT:C284($entityName; $businessType; $streetAddress; $city; $country; $businessTelNum; $businessTelNum; $issueCountry; $authorized1; $authorized2; $authorized3)
C_TEXT:C284($state; $streetAddress; $zipCode; $businessTelNum; $businessTelNumExt; $incNumber; $issueState)

// Part sequence number
$partSeqNum:=1

// Corporation, trust or other entity name
$entityName:=[Customers:3]FullName:40  // Company Name

// Type of business
$businessType:=[Customers:3]BusinessType:62

// Street address
$streetAddress:=[Customers:3]Address:7

// City
$city:=[Customers:3]City:8

// Country
$country:=[Customers:3]CountryCode:113

// Province/State
$state:=[Customers:3]Province:9

// Postal/zip code
$zipCode:=[Customers:3]PostalCode:10

// Business telephone number
$businessTelNum:=FT_Clean([Customers:3]WorkTel:12)

// Business telephone number extension
$businessTelNumExt:=[Customers:3]WorkTelExt:117

// Incorporation number 
$incNumber:=[Customers:3]BusinessIncorporationNo:65

// Country of issue
$issueCountry:=[Customers:3]BusinessIncorporatedInCountry:67

// Province/State of issue
$issueState:=[Customers:3]BusinessIncorportedInState:66




$authorized1:=""
$authorized2:=""
$authorized3:=""

READ ONLY:C145([CSMRelations:89])
QUERY:C277([CSMRelations:89]; [CSMRelations:89]CustomerID1:2=[Customers:3]CustomerID:1; *)
QUERY:C277([CSMRelations:89];  & ; [CSMRelations:89]isDirectorOf:9=1)



For ($i; 1; Records in selection:C76([CSMRelations:89]))
	
	Case of 
		: ($i=1)
			// Individuals authorized to bind the entity or act with respect to the account
			// Individual's name 2
			$authorized1:=[CSMRelations:89]FullName1:4
			
		: ($i=2)
			// Individuals authorized to bind the entity or act with respect to the account
			// Individual's name 2
			$authorized2:=[CSMRelations:89]FullName1:4
			
		: ($i=3)
			// Individuals authorized to bind the entity or act with respect to the account
			// Individual's name 2
			$authorized3:=[CSMRelations:89]FullName1:4
			
		Else 
			// Ignore
	End case 
	
End for 


FT_Part_EF($fileName; $partId; $partSeqNum; $entityName; $businessType; $streetAddress; $city; $country; $state; $zipCode; $businessTelNum; $businessTelNumExt; $incNumber; $issueCountry; $issueState; $authorized1; $authorized2; $authorized3)


