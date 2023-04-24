//%attributes = {"publishedSoap":true,"publishedWsdl":true}
//createCustomerIndViaWS ( firstname;lastname; 


// First name
// Last name

//Address, City, State, Country, and Zip Code
//Main Phone
//Email
//Date of birth
//social security number
//Ocupation
//Gross anual income
//Driver license#/other id#
//Expiration date for provided id




C_TEXT:C284($recordID)
C_POINTER:C301($errorMessagePtr)
C_TEXT:C284($firstName; $lastName; $email; $SS; $pictureID; $pictureIDType; $pictureIDIssued; $occupation; $mainPhone; $address; $city; $state; $zip; $country; $message)
C_DATE:C307($pictureIDExpDate; $DOB)


C_POINTER:C301($tablePtr; $fieldPtr)
C_TEXT:C284($recordID; $0)




//______________________________________________________________________
C_TEXT:C284($1; $2; $3; $5; $6; $7; $8; $9; $11; $12; $13; $14; $15; $16; $17)
C_POINTER:C301($18)
C_DATE:C307($4; $10)

$firstName:=$1
$lastName:=$2

$occupation:=$3
$dob:=$4
$mainPhone:=$5
$email:=$6
$SS:=$7

$pictureID:=$8
$pictureIDType:=$9
$pictureIDExpDate:=$10
$pictureIDIssued:=$11

$address:=$12
$city:=$13
$state:=$14
$zip:=$15
$country:=$16

$message:=$17
$errorMessagePtr:=$18

SOAP DECLARATION:C782($1; Is text:K8:3; SOAP input:K46:1; "firstName")
SOAP DECLARATION:C782($2; Is text:K8:3; SOAP input:K46:1; "lastName")

SOAP DECLARATION:C782($3; Is text:K8:3; SOAP input:K46:1; "occupation")
SOAP DECLARATION:C782($4; Is date:K8:7; SOAP input:K46:1; "DOB")
SOAP DECLARATION:C782($5; Is text:K8:3; SOAP input:K46:1; "mainPhone")
SOAP DECLARATION:C782($6; Is text:K8:3; SOAP input:K46:1; "email")
SOAP DECLARATION:C782($7; Is text:K8:3; SOAP input:K46:1; "SS")

SOAP DECLARATION:C782($8; Is text:K8:3; SOAP input:K46:1; "pictureID")
SOAP DECLARATION:C782($9; Is text:K8:3; SOAP input:K46:1; "PictureIDType")
SOAP DECLARATION:C782($10; Is date:K8:7; SOAP input:K46:1; "PictureIDExpDate")
SOAP DECLARATION:C782($11; Is text:K8:3; SOAP input:K46:1; "PictureIDIssue")

SOAP DECLARATION:C782($12; Is text:K8:3; SOAP input:K46:1; "address")
SOAP DECLARATION:C782($13; Is text:K8:3; SOAP input:K46:1; "city")
SOAP DECLARATION:C782($14; Is text:K8:3; SOAP input:K46:1; "state")
SOAP DECLARATION:C782($15; Is text:K8:3; SOAP input:K46:1; "zip")
SOAP DECLARATION:C782($16; Is text:K8:3; SOAP input:K46:1; "country")

SOAP DECLARATION:C782($17; Is text:K8:3; SOAP input:K46:1; "Message")

SOAP DECLARATION:C782($18; Is text:K8:3; SOAP output:K46:2; "ErrorMessage")
SOAP DECLARATION:C782($0; Is text:K8:3; SOAP output:K46:2; "CustomerID")



//__________________________________________________________

$tablePtr:=->[Customers:3]
$fieldPtr:=->[Customers:3]CustomerID:1

QUERY:C277([Customers:3]; [Customers:3]SIN_No:14=$SS; *)
QUERY:C277([Customers:3];  | ; [Customers:3]PictureID_Number:69=$pictureID; *)
QUERY:C277([Customers:3];  | ; [Customers:3]Email:17=$email)

If (Records in selection:C76($tablePtr->)=0)  // no record found matching the same email, pictureID, or SS# 
	READ WRITE:C146($tablePtr->)
	CREATE RECORD:C68($tablePtr->)
	$recordID:=makeCustomerID
	
	[Customers:3]CustomerID:1:=$recordID
	
	[Customers:3]FirstName:3:=$firstName
	[Customers:3]LastName:4:=$lastName
	
	[Customers:3]Occupation:21:=$occupation
	[Customers:3]DOB:5:=$dob
	[Customers:3]HomeTel:6:=$mainPhone
	[Customers:3]Email:17:=$email
	[Customers:3]SIN_No:14:=$SS
	
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