//%attributes = {}
// checkUniqueKey (->[LinkedDocs];->[LinkedDocs]LinkedDocID;"LinkedDocID")
//checkifRecordExists (->[Customers];->[Customers]CustomerID;->[LinkedDocs]CustomerID;"Customer ID")
//checkifRecordExists (->[LinkedDocs];->[LinkedDocs]DocReference;->[LinkedDocs]DocReference;"Document Reference";"WARN")
checkIfNullString(->[LinkedDocs:4]CustomerID:1; "Customer ID")
checkIfNullString(->[LinkedDocs:4]TypeOfDoc:5; "Document Type"; "WARN")
checkAddWarningOnTrue(isPictureIDExpired([LinkedDocs:4]ExpiryDate:4); "The document seem to be expired .")
checkIfDateIsBefore(->[LinkedDocs:4]IssueDate:21; True:C214; [LinkedDocs:4]ExpiryDate:4; "Issue Date")
checkIfDateIsBefore(->[LinkedDocs:4]IssueDate:21; True:C214; Current date:C33; "Issue Date")

C_LONGINT:C283($imageSize)
$imageSize:=Picture size:C356([LinkedDocs:4]ScannedImage:2)/1000

checkAddWarningOnTrue(($imageSize>150); "Size of image is larger than 150K"; "1")
checkAddErrorIf($imageSize>500; "Size of image is larger than 500K")  // cannot upload document larger than 500K (0.5 Mb)