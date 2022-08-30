//%attributes = {}
// FT_GeneratepartD1
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

QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$customerID)
If ([Customers:3]isCompany:41)
	// Surname
	$surname:=FT_Clean([Customers:3]FullName:40)
	$givenName:=""
	$otherName:=""
	
Else 
	
	// Surname
	$surname:=FT_Clean([Customers:3]LastName:4)
	
	// Given name
	$givenName:=FT_Clean([Customers:3]FirstName:3)
	
	// Other name/initial
	$otherName:=""
End if 


// Entity client number
$clientNumber:=$customerID

// Street address
If ([Customers:3]AddressUnitNo:148#"")
	$streetAddress:=FT_Clean([Customers:3]AddressUnitNo:148+"-"+[Customers:3]Address:7)
Else 
	$streetAddress:=FT_Clean([Customers:3]Address:7)
End if 



// City
$city:=FT_Clean([Customers:3]City:8)

// Country
$country:=FT_Clean([Customers:3]CountryCode:113)

// Province/State
$state:=FT_Clean([Customers:3]Province:9)

// Postal/zip code
$zipCode:=FT_Clean([Customers:3]PostalCode:10)

// Country of residence 
$countryOfResidence:=FT_Clean([Customers:3]CountryOfResidenceCode:114)

// Home telephone number
$indHomePhoneNumber:=FT_Clean([Customers:3]HomeTel:6)

// Individual's identifier A-Driver License, B-Birth certificate, C-Provincial health card, D-Passport, E-Other
If ([Customers:3]isCompany:41=False:C215)
	QUERY:C277([PictureIDTypes:92]; [PictureIDTypes:92]TemplateID:1=[Customers:3]PictureID_TemplateID:15)
	$indType:=Substring:C12([PictureIDTypes:92]GovernmentCode:15; 1; 1)
	$indType:=FT_StringFormat($indType; 2)
	
	If (Substring:C12([PictureIDTypes:92]GovernmentCode:15; 1; 1)#"E")
		$indTypeOtherDesc:=""
	Else 
		$indTypeOtherDesc:=[PictureIDTypes:92]Description:14  // type of picture ID
	End if 
Else 
	$indType:="E"
	$indType:=FT_StringFormat($indType; 2)
	$indTypeOtherDesc:="INCORPORATION NUMBER"
End if 


If ([Customers:3]isCompany:41=False:C215)  // Indivifual
	
	// ID number
	$indNum:=[Customers:3]PictureID_Number:69
	
	// Country of issue
	$indIssueCountry:=[Customers:3]PictureID_CountryCode:118
	
	// Province/State of issue
	$indIssueState:=[Customers:3]PictureID_IssueState:72
	
	// Individual's date of birth
	$indDateOfBirth:=FT_GetStringDate([Customers:3]DOB:5)
	
	// Individual's occupation
	$indOccupation:=FT_Clean([Customers:3]Occupation:21)
	
	// Individual's business telephone number
	$indBussinesPhone:=FT_Clean([Customers:3]WorkTel:12)
	
	// Individual's business telephone extension number
	$indBussinesPhoneExt:=FT_Clean([Customers:3]WorkTelExt:117)
	
Else 
	// Try to generate the business information
	// ID number
	$indNum:=FT_Clean([Customers:3]BusinessIncorporationNo:65)
	
	// Country of issue
	$indIssueCountry:=FT_Clean([Customers:3]BusinessIncorporatedInCountry:67)
	
	// Province/State of issue
	$indIssueState:=FT_Clean([Customers:3]BusinessIncorportedInState:66)
	
	// Individual's date of birth
	$indDateOfBirth:=FT_GetStringDate([Customers:3]BusinessIncorporationDate:29)
	
	// Individual's occupation
	$indOccupation:=FT_Clean([Customers:3]BusinessType:62)
	
	// Individual's business telephone number
	$indBussinesPhone:=FT_Clean([Customers:3]BusinessPhone1:63)
	
	// Individual's business telephone extension number
	$indBussinesPhoneExt:=FT_Clean([Customers:3]BusinessPhone2:64)
	
End if 


// Part D: Information about the individual conducting the transaction that is not a deposit into a business account (if applicable)
FT_partD($fileName; $partId; $partSeqNum; $surname; $givenName; $otherName; $clientNumber; $streetAddress; $city; $country; $state; $zipCode; $countryOfResidence; $indHomePhoneNumber; $indType; $indTypeOtherDesc; $indNum; $indIssueCountry; $indIssueState; $indDateOfBirth; $indOccupation; $indBussinesPhone; $indBussinesPhoneExt)

