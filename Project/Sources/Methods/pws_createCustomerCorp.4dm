//%attributes = {"publishedSoap":true,"publishedWsdl":true}
//pws_CreateCustomerCorp (  




C_TEXT:C284($recordID)
C_POINTER:C301($errorMessagePtr)
C_TEXT:C284($companyName; $industry; $email; $mainPhone; $taxID; $address; $city; $state; $zip; $country; $message)
C_TEXT:C284($firstName; $lastName; $pictureID; $pictureIDType; $pictureIDIssued)
C_DATE:C307($pictureIDExpDate; $DateOfInc)


C_POINTER:C301($tablePtr; $fieldPtr)
C_TEXT:C284($recordID; $0)



// Customer Name
// Address, City, State, Country, and Zip Code
// Main Phone
// Email
// Date of incorporation if business customer
// Tax ID number
// Industry of business
// Driver license#for principal/other id#
// Expiration date for provided id


//______________________________________________________________________
C_TEXT:C284($1; $2; $3; $4; $5; $6; $7; $8; $9; $11; $12; $13; $14; $15; $17; $18)
C_DATE:C307($10; $16)
C_POINTER:C301($19)


$companyName:=$1
$industry:=$2

$address:=$3
$city:=$4
$state:=$5
$zip:=$6
$country:=$7
$mainPhone:=$8

$email:=$9
$DateOfInc:=$10
$taxID:=$11

$firstName:=$12
$lastName:=$13
$pictureID:=$14
$pictureIDType:=$15
$pictureIDExpDate:=$16
$pictureIDIssued:=$17

$message:=$18
$errorMessagePtr:=$19

SOAP DECLARATION:C782($1; Is text:K8:3; SOAP input:K46:1; "CompanyName")
SOAP DECLARATION:C782($2; Is text:K8:3; SOAP input:K46:1; "Industry")

SOAP DECLARATION:C782($3; Is text:K8:3; SOAP input:K46:1; "Address")
SOAP DECLARATION:C782($4; Is text:K8:3; SOAP input:K46:1; "City")
SOAP DECLARATION:C782($5; Is text:K8:3; SOAP input:K46:1; "State")
SOAP DECLARATION:C782($6; Is text:K8:3; SOAP input:K46:1; "ZIP")
SOAP DECLARATION:C782($7; Is text:K8:3; SOAP input:K46:1; "Country")
SOAP DECLARATION:C782($8; Is text:K8:3; SOAP input:K46:1; "mainPhone")

SOAP DECLARATION:C782($9; Is text:K8:3; SOAP input:K46:1; "email")
SOAP DECLARATION:C782($10; Is date:K8:7; SOAP input:K46:1; "DateOfInc")
SOAP DECLARATION:C782($11; Is text:K8:3; SOAP input:K46:1; "TaxID")

SOAP DECLARATION:C782($12; Is text:K8:3; SOAP input:K46:1; "firstName")
SOAP DECLARATION:C782($13; Is text:K8:3; SOAP input:K46:1; "lastName")
SOAP DECLARATION:C782($14; Is text:K8:3; SOAP input:K46:1; "pictureID")
SOAP DECLARATION:C782($15; Is text:K8:3; SOAP input:K46:1; "pictureIDType")
SOAP DECLARATION:C782($16; Is date:K8:7; SOAP input:K46:1; "pictureIDExp")
SOAP DECLARATION:C782($17; Is text:K8:3; SOAP input:K46:1; "pictureIDIssued")

SOAP DECLARATION:C782($18; Is text:K8:3; SOAP input:K46:1; "Remarks")

SOAP DECLARATION:C782($19; Is text:K8:3; SOAP output:K46:2; "ErrorMessage")
SOAP DECLARATION:C782($0; Is text:K8:3; SOAP output:K46:2; "CustomerID")

//__________________________________________________________

$tablePtr:=->[Customers:3]
$fieldPtr:=->[Customers:3]CustomerID:1

QUERY:C277([Customers:3]; [Customers:3]SIN_No:14=$taxID)

If (Records in selection:C76($tablePtr->)=0)  // no record found matching the same email, pictureID, or SS# 
	READ WRITE:C146($tablePtr->)
	CREATE RECORD:C68($tablePtr->)
	$recordID:=makeCustomerID
	
	[Customers:3]CustomerID:1:=$recordID
	
	[Customers:3]CompanyName:42:=$companyName
	[Customers:3]TypeOfCompany:101:=$industry
	[Customers:3]isCompany:41:=True:C214
	[Customers:3]BusinessIncorporationNo:65:=$taxID
	[Customers:3]BusinessIncorportedInState:66:=$state
	[Customers:3]BusinessIncorporatedInCountry:67:=$country
	
	[Customers:3]FirstName:3:=$firstName
	[Customers:3]LastName:4:=$lastName
	[Customers:3]HomeTel:6:=$mainPhone
	[Customers:3]Email:17:=$email
	[Customers:3]SIN_No:14:=$taxID
	
	[Customers:3]PictureID_Number:69:=$pictureID
	[Customers:3]PictureID_Type:70:=$pictureIDType
	[Customers:3]PictureID_ExpiryDate:71:=$pictureIDExpDate
	[Customers:3]PictureID_IssueState:72:=$pictureIDIssued
	
	[Customers:3]Address:7:=$address
	[Customers:3]City:8:=$city
	[Customers:3]Province:9:=$state
	[Customers:3]PostalCode:10:=$zip
	[Customers:3]Country_obs:11:=$country
	
	[Customers:3]Comments:43:=$message
	$errorMessagePtr->:=""
	
	[Customers:3]isOnHold:52:=True:C214  // put the customer on hold automatically 
	
	[Customers:3]CreatedByUserID:58:="WebUser"
	[Customers:3]CreationDate:54:=Current date:C33
	[Customers:3]CreationTime:55:=Current time:C178
	
	
	SAVE RECORD:C53($tablePtr->)
	$recordID:=$fieldPtr->
	
	UNLOAD RECORD:C212($tablePtr->)
	READ ONLY:C145($tablePtr->)
	
	$0:=$recordID
	
Else 
	$errorMessagePtr->:="There was one or more records matching the ID, SS, or email"
	$0:=""
End if 