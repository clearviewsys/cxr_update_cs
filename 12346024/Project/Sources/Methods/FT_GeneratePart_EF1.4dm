//%attributes = {}
// FT_GeneratePart_EF1
// Part E1/F1: Information about the entity on whose behalf the transaction was conduct(if applicable)

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

C_LONGINT:C283($partSeqNum)
C_TEXT:C284($entityName; $businessType; $streetAddress; $city; $country; $businessTelNum; $businessTelNum; $issueCountry; $authorized1; $authorized2; $authorized3)
C_TEXT:C284($state; $streetAddress; $zipCode; $businessTelNum; $businessTelNumExt; $incNumber; $issueState)

// Part ID
//$partId:="F1"

// Part sequence number
$partSeqNum:=1

// Corporation, trust or other entity name
$entityName:=[ThirdParties:101]CompanyName:23

// Type of business
$businessType:=[ThirdParties:101]BusinessType:24

// Street address
$streetAddress:=[ThirdParties:101]Address:6

// City
$city:=[ThirdParties:101]City:7

// Country
$country:=[ThirdParties:101]CountryCode:8

// Province/State
$state:=[ThirdParties:101]theState:29

// Postal/zip code
$zipCode:=[ThirdParties:101]ZipCode:9

// Business telephone number
$businessTelNum:=FT_Clean([ThirdParties:101]WorkPhone:11)

// Business telephone number extension
$businessTelNumExt:=[ThirdParties:101]WorkPhoneExt:12

// Incorporation number 
$incNumber:=[ThirdParties:101]IncorporationNumber:25

// Country of issue
$issueCountry:=[ThirdParties:101]IdCountryOfIssue:18

// Province/State of issue
$issueState:=[ThirdParties:101]IdIssueState:19

// Individuals authorized to bind the entity or act with respect to the account
// Individual's name 1
$authorized1:=[ThirdParties:101]Authorized1:26

// Individuals authorized to bind the entity or act with respect to the account
// Individual's name 2
$authorized2:=[ThirdParties:101]Authorized2:27

//Individuals authorized to bind the entity or act with respect to the account
// Individual's name 3
$authorized3:=[ThirdParties:101]Authorized3:28

FT_Part_EF($fileName; $partId; $partSeqNum; $entityName; $businessType; $streetAddress; $city; $country; $state; $zipCode; $businessTelNum; $businessTelNumExt; $incNumber; $issueCountry; $issueState; $authorized1; $authorized2; $authorized3)


