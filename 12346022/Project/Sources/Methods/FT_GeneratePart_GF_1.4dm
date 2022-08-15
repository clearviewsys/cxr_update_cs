//%attributes = {}
// FT_GeneratePart_GF_1
// Information about the individual on whose behalf the transaction was conducted  (individual)

C_TEXT:C284($1; $fileName)

C_TEXT:C284($partId)
C_LONGINT:C283($partSeqNum)
C_TEXT:C284($indDateOfBirthday)

C_TEXT:C284($indRelation; $otherRel)
C_TEXT:C284($countryOfRes; $countryOfIssue; $issueState; $indOccupation; $indRelation)
C_TEXT:C284($businessTelNum; $businessTelNumExt; $indIdentifier; $otherDescription; $idNumber)
C_TEXT:C284($surname; $givenName; $otherName; $streetAddress; $city; $country; $state; $zipCode; $homeTelNum)



Case of 
	: (Count parameters:C259=1)
		$fileName:=$1
		$partId:="G1"
	: (Count parameters:C259=2)
		$fileName:=$1
		$partId:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// ------------------------------------------------------------------------------
// PartG : 
// Information about the individual on whose behalf the transaction was 
// conducted 
// ------------------------------------------------------------------------------


// Part ID
//$partId:="G1"

// Part sequence number
$partSeqNum:=1

// Surname
$surname:=[ThirdParties:101]LastName:3

// Given name
$givenName:=[ThirdParties:101]FirstName:4

// Other name/initial
$otherName:=[ThirdParties:101]OtherName:5

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

// Home  telephone number
$homeTelNum:=[ThirdParties:101]HomePhone:10

// Office telephone number
$businessTelNum:=[ThirdParties:101]WorkPhone:11

// Office telephone extension number 
$businessTelNumExt:=[ThirdParties:101]WorkPhoneExt:12

// Individual's date of birth
$indDateOfBirthday:=FT_GetStringDate([ThirdParties:101]DOB:13)

// Individual's identifier
$indIdentifier:=Substring:C12([ThirdParties:101]IdType:14; 1; 1)

// Other description
If ($indIdentifier="E")
	$otherDescription:=[ThirdParties:101]IdOtherType:15
Else 
	$otherDescription:=""
End if 

// ID number
$idNumber:=[ThirdParties:101]IdNumber:16

// Country of residence
$countryOfRes:=[ThirdParties:101]CountryOfResidence:17

// Country of issue
$countryOfIssue:=[ThirdParties:101]IdCountryOfIssue:18

// Province/State of issue (ID)
$issueState:=[ThirdParties:101]IdIssueState:19

// Individual's occupation
$indOccupation:=[ThirdParties:101]Occupation:20

// Relationship to individual
$indRelation:=Substring:C12([ThirdParties:101]RelationshipCode:21; 1; 1)

// Other relationship: This field is required if code "J" is entered in field "Relationship to individual"
If ($indRelation="J")
	$otherRel:=[ThirdParties:101]OtherRelationship:22
Else 
	$otherRel:=""
End if 


FT_Part_GF($fileName; $partId; $partSeqNum; $surname; $givenName; $otherName; $streetAddress; $city; $country; $state; $zipCode; $homeTelNum; $businessTelNum; $businessTelNumExt; $indDateOfBirthday; $indIdentifier; $otherDescription; $idNumber; $countryOfRes; $countryOfIssue; $issueState; $indOccupation; $indRelation; $otherRel)
