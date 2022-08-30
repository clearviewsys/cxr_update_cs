//%attributes = {}
// FT_GeneratePart_GF_1
// Information about the individual on whose behalf the transaction was conducted  (individual)

C_TEXT:C284($1; $fileName)

C_TEXT:C284($partId)
C_LONGINT:C283($partSeqNum)
C_TEXT:C284($indDateOfBirthday)

C_TEXT:C284($indRelation; $otherRel; $clientCode; $partSeqNumStr)
C_TEXT:C284($countryOfRes; $countryOfIssue; $issueState; $indOccupation; $indRelation)
C_TEXT:C284($businessTelNum; $businessTelNumExt; $indIdentifier; $otherDescription; $idNumber)
C_TEXT:C284($surname; $givenName; $otherName; $streetAddress; $city; $country; $state; $zipCode; $homeTelNum)
C_BLOB:C604($content)



Case of 
	: (Count parameters:C259=1)
		$fileName:=$1
		$partId:="D1"
	: (Count parameters:C259=2)
		$fileName:=$1
		$partId:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// Part D: Information about the individual conducting the transaction that is not (if applicable)
// This part is for information about the individual who conducted the transaction.
// A business account is an account for a business, for a non-profit organization, 
// etc.(i.e., one that is other than a personal or trust account).
// If the transaction and all its dispositions were a deposit to a business account.
//As explained earlier, it is possible to have more than one transaction per report. 
// Provide this information for each applicable transaction if at least one disposition is not a 
// deposit into a business account. For example, if there were two dispositions for a particular transaction 
// and they were both deposits to a business account (other than a night deposit or a quick drop), you would complete Part E. 
// If one of the dispositions was other than a deposit to a business account, you would complete Part D.

// Part sequence number
$partSeqNum:=1

// Surname
$surname:=FT_Clean([ThirdParties:101]LastName:3)

// Given name
$givenName:=FT_Clean([ThirdParties:101]FirstName:4)

// Other name/initial
$otherName:=FT_Clean([ThirdParties:101]OtherName:5)

// Client Code
$clientCode:=FT_Clean([ThirdParties:101]IdNumber:16)

// Street address
$streetAddress:=FT_Clean([ThirdParties:101]Address:6)

// City
$city:=FT_Clean([ThirdParties:101]City:7)

// Country
$country:=FT_Clean([ThirdParties:101]CountryCode:8)

// Province/State
$state:=FT_Clean([ThirdParties:101]theState:29)

// Postal/zip code
$zipCode:=FT_Clean([ThirdParties:101]ZipCode:9)

// Home  telephone number
$homeTelNum:=FT_Clean([ThirdParties:101]HomePhone:10)

// Office telephone number
$businessTelNum:=FT_Clean([ThirdParties:101]WorkPhone:11)

// Office telephone extension number 
$businessTelNumExt:=FT_Clean([ThirdParties:101]WorkPhoneExt:12)

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
$idNumber:=FT_Clean([ThirdParties:101]IdNumber:16)

// Country of residence
$countryOfRes:=FT_Clean([ThirdParties:101]CountryOfResidence:17)

// Country of issue
$countryOfIssue:=FT_Clean([ThirdParties:101]IdCountryOfIssue:18)

// Province/State of issue (ID)
$issueState:=FT_Clean([ThirdParties:101]IdIssueState:19)

// Individual's occupation
$indOccupation:=FT_Clean([ThirdParties:101]Occupation:20)

// Relationship to individual
$indRelation:=Substring:C12([ThirdParties:101]RelationshipCode:21; 1; 1)

// Other relationship: This field is required if code "J" is entered in field "Relationship to individual"
If ($indRelation="J")
	$otherRel:=[ThirdParties:101]OtherRelationship:22
Else 
	$otherRel:=""
End if 

// Part ID
$partId:=FT_StringFormat($partId; 2)
TEXT TO BLOB:C554($partId; $content; UTF8 text without length:K22:17; *)

// Part sequence number
$partSeqNumStr:=FT_NumberFormat($partSeqNum; 0; 2; "0"; "RJ")
TEXT TO BLOB:C554($partSeqNumStr; $content; UTF8 text without length:K22:17; *)

// Surname
$surname:=FT_StringFormat($surname; 20)
TEXT TO BLOB:C554($surname; $content; UTF8 text without length:K22:17; *)

// Given name
$givenName:=FT_StringFormat($givenName; 15)
TEXT TO BLOB:C554($givenName; $content; UTF8 text without length:K22:17; *)

// Other name/initial
$otherName:=FT_StringFormat($otherName; 10)
TEXT TO BLOB:C554($otherName; $content; UTF8 text without length:K22:17; *)

// Entity client number
$clientCode:=FT_StringFormat($clientCode; 12)
TEXT TO BLOB:C554($clientCode; $content; UTF8 text without length:K22:17; *)


// Street address
$streetAddress:=FT_StringFormat($streetAddress; 30)
TEXT TO BLOB:C554($streetAddress; $content; UTF8 text without length:K22:17; *)

// City
$city:=FT_StringFormat($city; 25)
TEXT TO BLOB:C554($city; $content; UTF8 text without length:K22:17; *)

// Country
$country:=FT_StringFormat($country; 2)
TEXT TO BLOB:C554($country; $content; UTF8 text without length:K22:17; *)

// Province/State
$state:=FT_StringFormat($state; 20)
TEXT TO BLOB:C554($state; $content; UTF8 text without length:K22:17; *)

// Postal/zip code
$zipCode:=FT_StringFormat($zipCode; 9)
TEXT TO BLOB:C554($zipCode; $content; UTF8 text without length:K22:17; *)


// Country of residence
$countryOfRes:=FT_StringFormat($countryOfRes; 2)
TEXT TO BLOB:C554($countryOfRes; $content; UTF8 text without length:K22:17; *)

// Home  telephone number
$homeTelNum:=FT_StringFormat($homeTelNum; 20)
TEXT TO BLOB:C554($homeTelNum; $content; UTF8 text without length:K22:17; *)

// Individual's identifier
$indIdentifier:=FT_StringFormat($indIdentifier; 1)
TEXT TO BLOB:C554($indIdentifier; $content; UTF8 text without length:K22:17; *)

// Other description
$otherDescription:=FT_StringFormat($otherDescription; 20)
TEXT TO BLOB:C554($otherDescription; $content; UTF8 text without length:K22:17; *)

// ID number
$idNumber:=FT_StringFormat($idNumber; 20)
TEXT TO BLOB:C554($idNumber; $content; UTF8 text without length:K22:17; *)

// Country of issue
$countryOfIssue:=FT_StringFormat($countryOfIssue; 2)
TEXT TO BLOB:C554($countryOfIssue; $content; UTF8 text without length:K22:17; *)


// Province/State of issue
$issueState:=FT_StringFormat($issueState; 20)
TEXT TO BLOB:C554($issueState; $content; UTF8 text without length:K22:17; *)

// Individual's date of birth
$indDateOfBirthday:=FT_StringFormat($indDateOfBirthday; 8)
TEXT TO BLOB:C554($indDateOfBirthday; $content; UTF8 text without length:K22:17; *)



// Individual's occupation
$indOccupation:=FT_StringFormat($indOccupation; 30)
TEXT TO BLOB:C554($indOccupation; $content; UTF8 text without length:K22:17; *)


// Office telephone number
$businessTelNum:=FT_StringFormat($businessTelNum; 20)
TEXT TO BLOB:C554($businessTelNum; $content; UTF8 text without length:K22:17; *)

// Office telephone extension number
$businessTelNumExt:=FT_StringFormat($businessTelNumExt; 10; "0"; "RJ")
TEXT TO BLOB:C554($businessTelNumExt; $content; UTF8 text without length:K22:17; *)


AppendBlobToFile($1; $content)