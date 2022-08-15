

//C_LONGINT($proc)
//$proc:=New process("ScanCustomerImage";256*1024;"ScanCustomerImage";->[Customers]Picture)



ARRAY POINTER:C280(arrFieldsToSet; 0)
ARRAY TEXT:C222(arrFieldsToGet; 0)

APPEND TO ARRAY:C911(arrFieldsToGet; "cvs_surname")
APPEND TO ARRAY:C911(arrFieldsToSet; ->[Customers:3]LastName:4)

APPEND TO ARRAY:C911(arrFieldsToGet; "cvs_given_name")
APPEND TO ARRAY:C911(arrFieldsToSet; ->[Customers:3]FirstName:3)

C_POINTER:C301($tablePtr)
C_TEXT:C284($form)
C_LONGINT:C283($windowType; $hpos; $vpos)
$tablePtr:=->[CompanyInfo:7]
$form:="ScanNewID"
$windowType:=Plain window:K34:13
$hpos:=Horizontally centered:K39:1
$vpos:=Vertically centered:K39:4

C_LONGINT:C283($winRef)
docPhoto:=[Customers:3]PictureID_Image:53
$winRef:=Open form window:C675($tablePtr->; $form; $windowType; $hpos; $vpos)
DIALOG:C40($tablePtr->; "ScanNewID")
[Customers:3]PictureID_Image:53:=docPhoto
//OCR_ScanNewID (->[Customers]Picture)
OCR_AssignFieldValues

