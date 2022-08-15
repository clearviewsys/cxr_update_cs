//%attributes = {}

// ------------------------------------------------------------------------------
// Method: FT_PartF1_STR : 
// Information about the individual on whose behalf the transaction was 
// conducted (if applicable) 
//
// This part only applies if the disposition was conducted on behalf of a third party 
// other than an individual, as indicated in Part B2. To include Part F, the on behalf 
// of indicator in Part B2 (field B13) has to be “E”.
// 
// Parameters: 
//   see above
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 12/13/2015
// ------------------------------------------------------------------------------


C_TEXT:C284($1; $repFileParh)  // Report file path (include file name)      
C_TEXT:C284($2)  // Part ID
C_LONGINT:C283($3)  // Part sequence number

C_TEXT:C284($partId; $partSeqNum; $surname; $givenName; $otherName; $streetAddress; $city; $country; $state; $zipCode)
C_TEXT:C284($homeTelNum; $businessTelNum; $indDateOfBirthday; $indIdentifier; $otherDescription; $countryOfRes)
C_TEXT:C284($issueState; $countryOfIssue; $issueState; $indOccupation; $employer)
C_TEXT:C284($employerAddress; $bphone; $bext; $rel; $orel)
C_TEXT:C284($businessTelNumExt; $idNumber; $fileName)

C_BLOB:C604($content)

// Part ID
$partId:=FT_StringFormat($2; 2)
TEXT TO BLOB:C554($partId; $content; UTF8 text without length:K22:17; *)

// Part sequence number
$partSeqNum:=FT_NumberFormat($3; 0; 2; "0"; "RJ")
TEXT TO BLOB:C554($partSeqNum; $content; UTF8 text without length:K22:17; *)

// Surname
$surname:=FT_StringFormat([ThirdParties:101]LastName:3; 20)
TEXT TO BLOB:C554($surname; $content; UTF8 text without length:K22:17; *)

// Given name
$givenName:=FT_StringFormat([ThirdParties:101]FirstName:4; 15)
TEXT TO BLOB:C554($givenName; $content; UTF8 text without length:K22:17; *)

// Other name/initial
$otherName:=FT_StringFormat([ThirdParties:101]OtherName:5; 10)
TEXT TO BLOB:C554($otherName; $content; UTF8 text without length:K22:17; *)

// Street address
$streetAddress:=FT_StringFormat([ThirdParties:101]Address:6; 30)
TEXT TO BLOB:C554($streetAddress; $content; UTF8 text without length:K22:17; *)

// City
$city:=FT_StringFormat([ThirdParties:101]City:7; 25)
TEXT TO BLOB:C554($city; $content; UTF8 text without length:K22:17; *)

// Country
$country:=FT_StringFormat([ThirdParties:101]CountryCode:8; 2)
TEXT TO BLOB:C554($country; $content; UTF8 text without length:K22:17; *)

// Province/State
$state:=FT_StringFormat([ThirdParties:101]theState:29; 20)
TEXT TO BLOB:C554($state; $content; UTF8 text without length:K22:17; *)

// Postal/zip code
$zipCode:=FT_StringFormat([ThirdParties:101]ZipCode:9; 9)
TEXT TO BLOB:C554($zipCode; $content; UTF8 text without length:K22:17; *)

// Home  telephone number
$homeTelNum:=FT_StringFormat([ThirdParties:101]HomePhone:10; 20)
TEXT TO BLOB:C554($homeTelNum; $content; UTF8 text without length:K22:17; *)

// Office telephone number
$businessTelNum:=FT_StringFormat([ThirdParties:101]WorkPhone:11; 20)
TEXT TO BLOB:C554($businessTelNum; $content; UTF8 text without length:K22:17; *)

// Office telephone extension number
$businessTelNumExt:=FT_StringFormat([ThirdParties:101]WorkPhoneExt:12; 10; "0"; "RJ")
TEXT TO BLOB:C554($businessTelNumExt; $content; UTF8 text without length:K22:17; *)

// Individual's date of birth
$indDateOfBirthday:=FT_GetStringDate([ThirdParties:101]DOB:13)
TEXT TO BLOB:C554($indDateOfBirthday; $content; UTF8 text without length:K22:17; *)

// Individual's identifier
$indIdentifier:=FT_StringFormat([ThirdParties:101]IdType:14; 1)
TEXT TO BLOB:C554($indIdentifier; $content; UTF8 text without length:K22:17; *)

If ($indIdentifier="E")  // Other
	// Other description
	$otherDescription:=FT_StringFormat([ThirdParties:101]OtherName:5; 20)
	TEXT TO BLOB:C554($otherDescription; $content; UTF8 text without length:K22:17; *)
Else 
	$otherDescription:=FT_StringFormat(" "; 20)
	TEXT TO BLOB:C554($otherDescription; $content; UTF8 text without length:K22:17; *)
End if 


// ID number
$idNumber:=FT_StringFormat([ThirdParties:101]IdNumber:16; 20)  // Field 13
TEXT TO BLOB:C554($idNumber; $content; UTF8 text without length:K22:17; *)

// Country of residence
$countryOfRes:=FT_StringFormat([ThirdParties:101]CountryOfResidence:17; 2)  // Field 14
TEXT TO BLOB:C554($countryOfRes; $content; UTF8 text without length:K22:17; *)

// Country of citizenship 
$countryOfIssue:=FT_StringFormat([ThirdParties:101]IdCountryOfIssue:18; 2)  // Field 14A
TEXT TO BLOB:C554($countryOfIssue; $content; UTF8 text without length:K22:17; *)

// Country of issue
$countryOfIssue:=FT_StringFormat([ThirdParties:101]IdCountryOfIssue:18; 2)  // Field 15
TEXT TO BLOB:C554($countryOfIssue; $content; UTF8 text without length:K22:17; *)


// Province/State of issue
$issueState:=FT_StringFormat([ThirdParties:101]IdIssueState:19; 20)  // Field 16
TEXT TO BLOB:C554($issueState; $content; UTF8 text without length:K22:17; *)


// Individual's occupation
$indOccupation:=FT_StringFormat([ThirdParties:101]Occupation:20; 30)  // Field 17
TEXT TO BLOB:C554($indOccupation; $content; UTF8 text without length:K22:17; *)


// Individual's occupation
$employer:=FT_StringFormat([ThirdParties:101]CompanyName:23; 35)  // Field 18
TEXT TO BLOB:C554($employer; $content; UTF8 text without length:K22:17; *)

// Employer address

// Address(30)+City(25)+Country(2)+state(20)+Zip Code(9)
$employerAddress:=FT_StringFormat(" "; 86)  //   Field 19-23
TEXT TO BLOB:C554($employerAddress; $content; UTF8 text without length:K22:17; *)

// Employer's business telephone number   // Field 24
$bphone:=FT_StringFormat([Customers:3]BusinessPhone2:64; 20)
TEXT TO BLOB:C554($bphone; $content; UTF8 text without length:K22:17; *)

//Employer's business telephone extension number Field 24A
$bext:=FT_StringFormat(" "; 10)
TEXT TO BLOB:C554($bext; $content; UTF8 text without length:K22:17; *)

//Relationship to individual   // Field 25
$rel:="J"
TEXT TO BLOB:C554($rel; $content; UTF8 text without length:K22:17; *)

$orel:="NOT REGISTERED"
TEXT TO BLOB:C554($orel; $content; UTF8 text without length:K22:17; *)
AppendBlobToFile($fileName; $content)




