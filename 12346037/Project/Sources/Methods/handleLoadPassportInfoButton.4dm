//%attributes = {}
C_TEXT:C284($gender)

read3MPassportXMLFile([Customers:3]CustomerID:1; ->[Customers:3]FirstName:3; ->[Customers:3]LastName:4; ->[Customers:3]Gender:120; ->[Customers:3]CountryOfBirthCode:18; ->[Customers:3]DOB:5; ->[Customers:3]PictureID_Number:69; ->[Customers:3]PictureID_ExpiryDate:71; ->[Customers:3]PictureID_IssueDate:16; ->[Customers:3]SIN_No:14; ->[Customers:3]Gender:120)

C_TEXT:C284($filePath)
$filePath:=getFilePathByID("3M Scanner:ScanFolder")+[Customers:3]CustomerID:1+"-visible.bmp"
openPictureID(->[Customers:3]PictureID_Image:53; $filePath)
C_PICTURE:C286(vLoadedPicture)
vLoadedPicture:=[Customers:3]PictureID_Image:53
scaleImage(->[Customers:3]PictureID_Image:53; 0.36)
cropImageFromAllSides(->[Customers:3]PictureID_Image:53; 0.01)
lockCustomerPassportFields  // lock fields 

//$filename:=$1
//$firstNamesPtr:=$2
//$lastNamePtr:=$3
//$genderPtr:=$4
//$nationalityPtr:=$5
//$DOBPtr:=$6
//$passportIDPtr:=$7
//$expiryDatePtr:=$8
