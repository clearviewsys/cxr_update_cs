//%attributes = {}
// handleWizzFormsButton ( ->picture)

C_POINTER:C301($picturePtr; $1)

Case of 
	: (Count parameters:C259=0)
		$picturePtr:=->[Customers:3]PictureID_Image:53
	: (Count parameters:C259=1)
		$picturePtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

readWizzFormXMLFile(->[Customers:3]FirstName:3; ->[Customers:3]LastName:4; ->[Customers:3]Gender:120; ->[Customers:3]PictureID_CountryCode:118; ->[Customers:3]DOB:5; ->[Customers:3]PictureID_Number:69; ->[Customers:3]PictureID_ExpiryDate:71; ->[Customers:3]PictureID_IssueDate:16; ->[Customers:3]SIN_No:14; ->[Customers:3]Gender:120; ->[Customers:3]Address:7; ->[Customers:3]Province:9; ->[Customers:3]City:8; ->[Customers:3]CountryCode:113)
[Customers:3]FullName:40:=makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4)
handleCustomerNameEntryField(->[Customers:3]FullName:40)
//checkCustomerFullName 

C_TEXT:C284($filePath)
$filePath:=getFilePathByID("WizzForms:Image")
If ($filePath#"")
	openPictureID($picturePtr; $filePath)
	C_PICTURE:C286(vLoadedPicture)
	vLoadedPicture:=$picturePtr->
	
	scaleImage($picturePtr; 0.35)
	cropImageFromAllSides($picturePtr; 0.03)
	lockCustomerPassportFields  // lock fields 
Else 
	myAlert("Invalid filePath WizzForms:Image")
End if 

