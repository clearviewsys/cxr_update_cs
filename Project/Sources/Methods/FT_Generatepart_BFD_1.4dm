//%attributes = {}
// FT_Generatepart_BFD_1
// Generate information about the individual conducting the transaction 

C_TEXT:C284($1; $fileName; $2; $customerID; $3; $partId; $4; $orderingPart)
C_BOOLEAN:C305($5; $isEFTO)
Case of 
	: (Count parameters:C259=2)
		$fileName:=$1
		$customerID:=$2
		$partId:="B1"
		$orderingPart:="Customers"
		$isEFTO:=False:C215
		
	: (Count parameters:C259=3)
		$fileName:=$1
		$customerID:=$2
		$partId:=$3
		$orderingPart:="Customers"
		$isEFTO:=False:C215
		
	: (Count parameters:C259=4)
		$fileName:=$1
		$customerID:=$2
		$partId:=$3
		$orderingPart:=$4
		$isEFTO:=False:C215
		
	: (Count parameters:C259=5)
		$fileName:=$1
		$customerID:=$2
		$partId:=$3
		$orderingPart:=$4
		$isEFTO:=$5
		
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


// Part ID
// $partId:= "B1" Default B1

// Part sequence number
C_LONGINT:C283($partSeqNum)
$partSeqNum:=1

READ ONLY:C145([Customers:3])
QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$customerID)

C_TEXT:C284($fullName)
$fullName:=[Customers:3]FullName:40

// Surname
C_TEXT:C284($surname)
$surname:=[Customers:3]LastName:4

// Given name
C_TEXT:C284($givenName)
$givenName:=[Customers:3]FirstName:3

// Other name/initial
C_TEXT:C284($otherName)
$otherName:=""


// Entity client number
C_TEXT:C284($clientNumber)
$clientNumber:=$customerID

// Street address
C_TEXT:C284($streetAddress)
$streetAddress:=[Customers:3]Address:7

// City
C_TEXT:C284($city)
$city:=[Customers:3]City:8

// Country
C_TEXT:C284($country)
$country:=[Customers:3]CountryCode:113

// Province/State
C_TEXT:C284($state)
$state:=[Customers:3]Province:9

// Postal/zip code
C_TEXT:C284($zipCode)
$zipCode:=[Customers:3]PostalCode:10

// Country of residence 
C_TEXT:C284($countryOfResidence)
$countryOfResidence:=[Customers:3]CountryOfResidenceCode:114

// Home telephone number
C_TEXT:C284($indHomePhoneNumber)
$indHomePhoneNumber:=[Customers:3]HomeTel:6

// Individual's identifier A-Driver License, B-Birth certificate, C-Provincial health card, D-Passport, E-Other
C_TEXT:C284($indType; $indTypeOtherDesc)


QUERY:C277([PictureIDTypes:92]; [PictureIDTypes:92]TemplateID:1=[Customers:3]PictureID_TemplateID:15)
$indType:=Substring:C12([PictureIDTypes:92]GovernmentCode:15; 1; 1)
If (Substring:C12([PictureIDTypes:92]GovernmentCode:15; 1; 1)#"E")
	$indTypeOtherDesc:=""
Else 
	$indTypeOtherDesc:=[PictureIDTypes:92]Description:14  // type of picture ID
End if 

// ID number
C_TEXT:C284($indNum)
$indNum:=FJ_Trim([Customers:3]PictureID_Number:69)

// Country of issue
C_TEXT:C284($indIssueCountry)
$indIssueCountry:=FJ_Trim([Customers:3]PictureID_IssueCountry:73)

// Province/State of issue
C_TEXT:C284($indIssueState)
$indIssueState:=[Customers:3]PictureID_IssueState:72

// Individual's date of birth
C_TEXT:C284($indDateOfBirth)
$indDateOfBirth:=FT_GetStringDate([Customers:3]DOB:5)

// Individual's occupation
C_TEXT:C284($indOccupation)
$indOccupation:=FJ_Trim(FT_Clean([Customers:3]Occupation:21))

// Individual's business telephone number
C_TEXT:C284($indBussinesPhone)
$indBussinesPhone:=FJ_Trim(FT_Clean([Customers:3]WorkTel:12))

// Individual's business telephone extension number
C_TEXT:C284($indBussinesPhoneExt)
$indBussinesPhoneExt:=FJ_Trim(FT_Clean([Customers:3]WorkTelExt:117))

// Part D: Information about the individual conducting the transaction that is not a deposit into a business account (if applicable)
FT_PartBD_1($fileName; [Customers:3]CustomerID:1; $partId; $orderingPart; $isEFTO)


