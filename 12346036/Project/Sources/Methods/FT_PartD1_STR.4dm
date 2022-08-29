//%attributes = {}

// ------------------------------------------------------------------------------
// Method: FT_PartD1_STR : 
// 
// Part D: Information about the individual conducting the transaction if it is not a deposit into a business 
// account (if applicable)
// This part is for information about the individual who conducted the transaction if any of this transaction's 
// dispositions was not a deposit into a business account. If the transaction involved nothing other than 
// deposits to a business account, complete Part E
// If the transaction was a deposit to a business account by night deposit or quick 
// neither of Parts D, E, F or G applies.
// -----------------------------------------------------------------------------------------------------------
// 
// Parameters: 
//   see above
//
// Return:

//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 5/5/2020
// ------------------------------------------------------------------------------


C_TEXT:C284($1; $fileName)  // Report file path (include file name)      
C_TEXT:C284($2; $customerId)  // Customer ID
C_TEXT:C284($3; $partId)
C_LONGINT:C283($4; $partSeq)


Case of 
		
	: (Count parameters:C259=4)
		
		$fileName:=$1
		$customerId:=$2
		$partId:=$3
		$partSeq:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


C_BLOB:C604($content)
C_TEXT:C284($tmp; $surname; $givenname; $middle; $streetAddress; $city; $country)
C_TEXT:C284($clientNumber; $streetAddress; $city; $country; $state; $country; $zipCode; $countryOfResidence)
C_TEXT:C284($countryOfCitizenship; $indHomePhoneNumber; $inType; $indTypeOtherDesc; $idNumber; $idCountryOfIssue)
C_TEXT:C284($indType; $idStateOfIssue; $indBusinessPhoneNumber; $indBusinessPhoneNumberExt; $employer; $employerAddress; $bphone; $bext)

C_TEXT:C284($state; $zipCode; $indHomePhoneNumber; $indDateOfBirth; $indOccupation)
C_TEXT:C284($account; $indTypeOtherDesc; $indNum)

QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$customerId)

// Part ID
TEXT TO BLOB:C554($partId; $content; UTF8 text without length:K22:17; *)

$tmp:=FT_NumberFormat($partSeq; 0; 2)
TEXT TO BLOB:C554($tmp; $content; UTF8 text without length:K22:17; *)


$surname:=FT_StringFormat([Customers:3]LastName:4; 20; " ")  // Field 1
TEXT TO BLOB:C554($surname; $content; UTF8 text without length:K22:17; *)

$givenname:=FT_StringFormat([Customers:3]FirstName:3; 15; " ")  // Field 2
TEXT TO BLOB:C554($givenname; $content; UTF8 text without length:K22:17; *)

$middle:=FT_StringFormat(""; 10; " "; "LJ")  // Field 3
TEXT TO BLOB:C554($middle; $content; UTF8 text without length:K22:17; *)

// Entity client number
$clientNumber:=FT_StringFormat([Customers:3]CustomerID:1; 12)  // Field 4
TEXT TO BLOB:C554($clientNumber; $content; UTF8 text without length:K22:17; *)

// -----------------------------------------------------------

// Street address
$streetAddress:=FT_StringFormat([Customers:3]Address:7; 30)  // Field 5
TEXT TO BLOB:C554($streetAddress; $content; UTF8 text without length:K22:17; *)

// City
$city:=FT_StringFormat([Customers:3]City:8; 25)  // Field 6
TEXT TO BLOB:C554($city; $content; UTF8 text without length:K22:17; *)

// Country
$country:=FT_StringFormat([Customers:3]CountryCode:113; 2)  // Field 7
TEXT TO BLOB:C554($country; $content; UTF8 text without length:K22:17; *)


// -----------------------------------------------------------

// Province/State
$state:=FT_StringFormat([Customers:3]Province:9; 20)  // Field 8
TEXT TO BLOB:C554($state; $content; UTF8 text without length:K22:17; *)

// Postal/zip code
$zipCode:=FT_StringFormat([Customers:3]PostalCode:10; 9)  // Field 9
TEXT TO BLOB:C554($zipCode; $content; UTF8 text without length:K22:17; *)


// Country of residence
$countryOfResidence:=FT_StringFormat([Customers:3]CountryOfResidenceCode:114; 2)  // Field 10
TEXT TO BLOB:C554($countryOfResidence; $content; UTF8 text without length:K22:17; *)

// Country of citizenship
$countryOfCitizenship:=FT_StringFormat([Customers:3]CountryOfBirthCode:18; 2)  // Field 10A
TEXT TO BLOB:C554($countryOfCitizenship; $content; UTF8 text without length:K22:17; *)


// Home telephone number
$indHomePhoneNumber:=FT_StringFormat([Customers:3]HomeTel:6; 20)  // Field 11
TEXT TO BLOB:C554($indHomePhoneNumber; $content; UTF8 text without length:K22:17; *)


// Individual's identifier A-Driver License, B-Birth certificate, C-Provincial health card, D-Passport, E-Other

QUERY:C277([PictureIDTypes:92]; [PictureIDTypes:92]TemplateID:1=[Customers:3]PictureID_TemplateID:15)
$indType:=Substring:C12([PictureIDTypes:92]GovernmentCode:15; 1; 1)  // Field 11
If (Substring:C12([PictureIDTypes:92]GovernmentCode:15; 1; 1)#"E")
	$indTypeOtherDesc:=""
Else 
	$indTypeOtherDesc:=[PictureIDTypes:92]Description:14  // type of picture ID  // Field 12 A
End if 


TEXT TO BLOB:C554($indType; $content; UTF8 text without length:K22:17; *)

$indTypeOtherDesc:=FT_StringFormat($indTypeOtherDesc; 20)  // Field 12A
TEXT TO BLOB:C554($indTypeOtherDesc; $content; UTF8 text without length:K22:17; *)


//ID number
$idNumber:=FT_StringFormat([Customers:3]PictureID_Number:69; 20)  // Field 13
TEXT TO BLOB:C554($idNumber; $content; UTF8 text without length:K22:17; *)


//ID Country of issue
$idCountryOfIssue:=FT_StringFormat([Customers:3]PictureID_IssueCountry:73; 2)  // Field 14
TEXT TO BLOB:C554($idCountryOfIssue; $content; UTF8 text without length:K22:17; *)

//Province/State of issue
$idStateOfIssue:=FT_StringFormat([Customers:3]PictureID_Authority:116; 20)  // Field 15
TEXT TO BLOB:C554($idStateOfIssue; $content; UTF8 text without length:K22:17; *)

// Individual's date of birth
If ([Customers:3]DOB:5#!00-00-00!)  // Field 16
	$indDateOfBirth:=FT_GetStringDate([Customers:3]DOB:5)
Else 
	$indDateOfBirth:=FT_StringFormat(" "; 8)
End if 

TEXT TO BLOB:C554($indDateOfBirth; $content; UTF8 text without length:K22:17; *)

// Individual's occupation
$indOccupation:=FT_StringFormat([Customers:3]Occupation:21; 30)  // Field 17
TEXT TO BLOB:C554($indOccupation; $content; UTF8 text without length:K22:17; *)



// Individual's business telephone number
$indBusinessPhoneNumber:=FT_StringFormat([Customers:3]WorkTel:12; 20)  // Field 18
TEXT TO BLOB:C554($indBusinessPhoneNumber; $content; UTF8 text without length:K22:17; *)


// Individual's business telephone extension number
$indBusinessPhoneNumberExt:=FT_StringFormat([Customers:3]BusinessPhone2:64; 10)  // Field 18A
TEXT TO BLOB:C554($indBusinessPhoneNumberExt; $content; UTF8 text without length:K22:17; *)


// Individual's employer
// Enter the name of the entity or individual who is the employer of the individual who 
// conducted or attempted to conduct the transaction.
// This field requires reasonable efforts.


$employer:=FT_StringFormat([Customers:3]CompanyName:42; 35)  // Field 19
TEXT TO BLOB:C554($employer; $content; UTF8 text without length:K22:17; *)



// Employer address

// Address(30)+City(25)+Country(2)+state(20)+Zip Code(9)
$employerAddress:=FT_StringFormat(" "; 86)  //   Field 20-24
TEXT TO BLOB:C554($employerAddress; $content; UTF8 text without length:K22:17; *)

// Employer's business telephone number   // Field 25
$bphone:=FT_StringFormat([Customers:3]BusinessPhone2:64; 20)
TEXT TO BLOB:C554($bphone; $content; UTF8 text without length:K22:17; *)

//Employer's business telephone extension number Field 25A
$bext:=FT_StringFormat(" "; 10)
TEXT TO BLOB:C554($bext; $content; UTF8 text without length:K22:17; *)


AppendBlobToFile($fileName; $content)







