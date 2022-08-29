//%attributes = {}


ARRAY POINTER:C280(arrFieldsToSet; 0)
ARRAY TEXT:C222(arrFieldsToGet; 0)

APPEND TO ARRAY:C911(arrFieldsToGet; "cvs_surname")
APPEND TO ARRAY:C911(arrFieldsToSet; ->[Customers:3]LastName:4)

APPEND TO ARRAY:C911(arrFieldsToGet; "cvs_given_name")
APPEND TO ARRAY:C911(arrFieldsToSet; ->[Customers:3]FirstName:3)


OCR_ScanNewID(->[Customers:3]PictureID_Image:53)
OCR_AssignFieldValues