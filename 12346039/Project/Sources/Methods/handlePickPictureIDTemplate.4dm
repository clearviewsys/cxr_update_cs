//%attributes = {}
// handlePickPictureIDTemplate ({isForced})
// 

C_BOOLEAN:C305($isForced; $1)
C_POINTER:C301($abbrPtr; $PictureID_objPtr; $pictureIDTypePtr; $countryPtr; $statePtr; $authorityPtr; $expDatePtr; $issueDatePtr; $govPtr)

Case of 
	: (Count parameters:C259=0)
		$isForced:=False:C215
	: (Count parameters:C259=1)
		$isForced:=True:C214
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$abbrPtr:=->[Customers:3]PictureID_TemplateID:15  // self in this case
$PictureID_objPtr:=->[Customers:3]PictureID_Number:69  // the object that will be reformatted
$pictureIDTypePtr:=->[Customers:3]PictureID_Type:70
$countryPtr:=->[Customers:3]PictureID_CountryCode:118
$statePtr:=->[Customers:3]PictureID_IssueState:72
$authorityPtr:=->[Customers:3]PictureID_Authority:116
$issueDatePtr:=->[Customers:3]PictureID_IssueDate:16
$expDatePtr:=->[Customers:3]PictureID_ExpiryDate:71
$govPtr:=->[Customers:3]PictureID_GovernmentCode:20

pickPictureIDType($abbrPtr; $PictureID_objPtr; $pictureIDTypePtr; $countryPtr; $statePtr; $authorityPtr; $issueDatePtr; $expDatePtr; $govPtr; $isForced)
If (OK=1)
	OBJECT SET TITLE:C194(*; "PictureIDDescription"; [PictureIDTypes:92]Description:14)
End if 