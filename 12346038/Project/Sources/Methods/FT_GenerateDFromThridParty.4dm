//%attributes = {}
// FT_GenerateDFromThridParty
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
C_TEXT:C284($indType; $indTypeOtherDesc; $indNum; $indIssueCountry; $indIssueState; $indDateOfBirth; $indOccupation; $indBussinesPhone; $indBussinesPhoneExt)
C_LONGINT:C283($partSeqNum)
// Part ID
$partId:="D1"

// Part sequence number
$partSeqNum:=1


// Surname
$surname:=FT_Clean([ThirdParties:101]LastName:3)

// Given name
$givenName:=FT_Clean([ThirdParties:101]FirstName:4)

// Other name/initial
$otherName:=FT_Clean([ThirdParties:101]OtherName:5)


// Entity client number
$clientNumber:=" "  //12

// Street address

$streetAddress:=FT_Clean([ThirdParties:101]Address:6)



// City
$city:=[ThirdParties:101]City:7

// Country
$country:=FT_Clean([ThirdParties:101]CountryCode:8)

// Province/State
$state:=FT_Clean([ThirdParties:101]theState:29)

// Postal/zip code
$zipCode:=FT_Clean([ThirdParties:101]ZipCode:9)

// Country of residence 
$countryOfResidence:=FT_Clean([ThirdParties:101]CountryOfResidence:17)

// Home telephone number
$indHomePhoneNumber:=FT_Clean([ThirdParties:101]HomePhone:10)

// Individual's identifier A-Driver License, B-Birth certificate, C-Provincial health card, D-Passport, E-Other


$indType:=Substring:C12([ThirdParties:101]IdType:14; 1; 1)
$indType:=FT_StringFormat($indType; 1)

If (Substring:C12([PictureIDTypes:92]GovernmentCode:15; 1; 1)#"E")
	$indTypeOtherDesc:=""
Else 
	$indTypeOtherDesc:=Substring:C12([ThirdParties:101]IdType:14; 3)
End if 

$indNum:=[ThirdParties:101]IdNumber:16  //20

// Country of issue
$indIssueCountry:=[ThirdParties:101]IdCountryOfIssue:18

// Province/State of issue
$indIssueState:=[ThirdParties:101]IdIssueState:19

// Individual's date of birth
$indDateOfBirth:=FT_GetStringDate([ThirdParties:101]DOB:13)

// Individual's occupation
$indOccupation:=[ThirdParties:101]Occupation:20

// Individual's business telephone number
$indBussinesPhone:=[ThirdParties:101]WorkPhone:11

// Individual's business telephone extension number
$indBussinesPhoneExt:=[ThirdParties:101]WorkPhoneExt:12


// Part D: Information about the individual conducting the transaction that is not a deposit into a business account (if applicable)
FT_partD($fileName; $partId; $partSeqNum; $surname; $givenName; $otherName; $clientNumber; $streetAddress; $city; $country; $state; $zipCode; $countryOfResidence; $indHomePhoneNumber; $indType; $indTypeOtherDesc; $indNum; $indIssueCountry; $indIssueState; $indDateOfBirth; $indOccupation; $indBussinesPhone; $indBussinesPhoneExt)

