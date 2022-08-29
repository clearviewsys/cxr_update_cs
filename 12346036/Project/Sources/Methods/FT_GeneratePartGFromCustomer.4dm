//%attributes = {}
// FT_GeneratePartGFromCustomer
// Generate information about the individual conducting the transaction 

C_TEXT:C284($1; $fileName; $2; $customerID)

Case of 
	: (Count parameters:C259=2)
		$fileName:=$1
		$customerID:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


// -----------------------------------------------------------------------------------------------------------
// Part D: Information about the individual conducting the transaction if it is not a deposit into a business 
// account (if applicable)
// This part is for information about the individual who conducted the transaction if any of this transaction's 
// dispositions was not a deposit into a business account. If the transaction involved nothing other than 
// deposits to a business account, complete Part E
// If the transaction was a deposit to a business account by night deposit or quick 
// neither of Parts D, E, F or G applies.
// -----------------------------------------------------------------------------------------------------------

C_TEXT:C284($partId; $surname; $givenName; $otherName; $otherName; $clientNumber; $streetAddress; $city; $country; $state; $zipCode; $countryOfResidence; $indHomePhoneNumber)
C_TEXT:C284($indType; $indTypeOtherDesc; $indNum; $indIssueCountry; $indIssueState; $indDateOfBirth; $indOccupation; $indBussinesPhone; $indBussinesPhoneExt; $tmp; $occupation)
C_LONGINT:C283($partSeqNum)
C_BLOB:C604($content)

// Part ID
$partId:="G1"

// Part sequence number
$partSeqNum:=1

QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$customerID)



// Entity client number
$clientNumber:=$customerID


// Country of residence 
$countryOfResidence:=FT_Clean([Customers:3]CountryOfResidenceCode:114)

// Home telephone number
$indHomePhoneNumber:=FT_Clean([Customers:3]HomeTel:6)




// -----------------------

// Part ID
$partId:=FT_StringFormat($partId; 2)
TEXT TO BLOB:C554($partId; $content; UTF8 text without length:K22:17; *)

// Part sequence number
$tmp:=FT_NumberFormat($partSeqNum; 0; 2; "0"; "RJ")
TEXT TO BLOB:C554($tmp; $content; UTF8 text without length:K22:17; *)

// Surname
$surname:=FT_Clean([Customers:3]LastName:4)
$surname:=FT_StringFormat($surname; 20)
TEXT TO BLOB:C554($surname; $content; UTF8 text without length:K22:17; *)

// -----------------------------------------------------------

// Given name
$givenName:=FT_Clean([Customers:3]FirstName:3)
$givenName:=FT_StringFormat($givenName; 15)
TEXT TO BLOB:C554($givenName; $content; UTF8 text without length:K22:17; *)

// Other name/initial
$otherName:=""
$otherName:=FT_StringFormat($otherName; 10)
TEXT TO BLOB:C554($otherName; $content; UTF8 text without length:K22:17; *)

// Entity client number
//$clientNumber:=FT_StringFormat ($7;12)
//TEXT TO BLOB($clientNumber;$content;UTF8 text without length;*)

// -----------------------------------------------------------

// Street address
If ([Customers:3]AddressUnitNo:148#"")
	$streetAddress:=FT_Clean([Customers:3]AddressUnitNo:148+"-"+[Customers:3]Address:7)
Else 
	$streetAddress:=FT_Clean([Customers:3]Address:7)
End if 

// Street address
$streetAddress:=FT_StringFormat($streetAddress; 30)
TEXT TO BLOB:C554($streetAddress; $content; UTF8 text without length:K22:17; *)

// City
// City
$city:=[Customers:3]City:8
$city:=FT_StringFormat($city; 25)
TEXT TO BLOB:C554($city; $content; UTF8 text without length:K22:17; *)

// Country
$country:=FT_Clean([Customers:3]CountryCode:113)
$country:=FT_StringFormat($country; 2)
TEXT TO BLOB:C554($country; $content; UTF8 text without length:K22:17; *)


// -----------------------------------------------------------
// Province/State
$state:=FT_Clean([Customers:3]Province:9)
$state:=FT_StringFormat($state; 20)
TEXT TO BLOB:C554($state; $content; UTF8 text without length:K22:17; *)


// Postal/zip code
$zipCode:=FT_Clean([Customers:3]PostalCode:10)
$zipCode:=FT_StringFormat($zipCode; 9)
TEXT TO BLOB:C554($zipCode; $content; UTF8 text without length:K22:17; *)

// Home telephone number
C_TEXT:C284($indHomePhoneNumber)
$indHomePhoneNumber:=FT_StringFormat([Customers:3]HomeTel:6; 20)
TEXT TO BLOB:C554($indHomePhoneNumber; $content; UTF8 text without length:K22:17; *)

// Office telephone number
C_TEXT:C284($indOfficePhoneNumber)
$indOfficePhoneNumber:=FT_StringFormat([Customers:3]WorkTel:12; 20)
TEXT TO BLOB:C554($indOfficePhoneNumber; $content; UTF8 text without length:K22:17; *)

// Office telephone number Ext
C_TEXT:C284($indOfficePhoneNumberExt)
$indOfficePhoneNumberExt:=FT_StringFormat([Customers:3]WorkTelExt:117; 10)
TEXT TO BLOB:C554($indOfficePhoneNumberExt; $content; UTF8 text without length:K22:17; *)

// Individual's date of birth
$indDateOfBirth:=FT_GetStringDate([Customers:3]DOB:5)
TEXT TO BLOB:C554($indDateOfBirth; $content; UTF8 text without length:K22:17; *)

// Individual's identifier A-Driver License, B-Birth certificate, C-Provincial health card, D-Passport, E-Other

QUERY:C277([PictureIDTypes:92]; [PictureIDTypes:92]TemplateID:1=[Customers:3]PictureID_TemplateID:15)
$indType:=Substring:C12([PictureIDTypes:92]GovernmentCode:15; 1; 1)
$indType:=FT_StringFormat($indType; 2)

If (Substring:C12([PictureIDTypes:92]GovernmentCode:15; 1; 1)#"E")
	$indTypeOtherDesc:=""
Else 
	$indTypeOtherDesc:=[PictureIDTypes:92]Description:14  // type of picture ID
End if 

// Individual's identifier
$indType:=FT_StringFormat($indType; 1)
TEXT TO BLOB:C554($indType; $content; UTF8 text without length:K22:17; *)

// Id type Other description for code  'E' in $idType
$indTypeOtherDesc:=FT_StringFormat($indTypeOtherDesc; 20)
TEXT TO BLOB:C554($indTypeOtherDesc; $content; UTF8 text without length:K22:17; *)

$indNum:=FT_StringFormat([Customers:3]PictureID_Number:69; 20)
TEXT TO BLOB:C554($indNum; $content; UTF8 text without length:K22:17; *)

// Country of Residence
$indIssueCountry:=FT_StringFormat([Customers:3]CountryOfResidenceCode:114; 2)
TEXT TO BLOB:C554($indIssueCountry; $content; UTF8 text without length:K22:17; *)

// Country of issue
$indIssueCountry:=FT_StringFormat([Customers:3]PictureID_CountryCode:118; 2)
TEXT TO BLOB:C554($indIssueCountry; $content; UTF8 text without length:K22:17; *)

// Province/State of issue
$indIssueState:=FT_StringFormat([Customers:3]PictureID_IssueState:72; 20)
TEXT TO BLOB:C554($indIssueState; $content; UTF8 text without length:K22:17; *)


// Individual Occupation
$occupation:=FT_StringFormat([Customers:3]Occupation:21; 30)
TEXT TO BLOB:C554($occupation; $content; UTF8 text without length:K22:17; *)

$tmp:="J"  //Relationship: Other
TEXT TO BLOB:C554($tmp; $content; UTF8 text without length:K22:17; *)

$tmp:=[ThirdParties:101]OtherRelationship:22
$tmp:=FT_StringFormat($tmp; 20)
TEXT TO BLOB:C554($tmp; $content; UTF8 text without length:K22:17; *)

AppendBlobToFile($1; $content)


