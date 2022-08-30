//%attributes = {}
checkIfNullString(->[LinkedDocs:4]CustomerID:1; "Customer ID")
checkifRecordExists(->[Customers:3]; ->[Customers:3]CustomerID:1; ->[LinkedDocs:4]CustomerID:1; "Customer ID")
checkIfNullString(->[LinkedDocs:4]DocReference:6; "Picture ID Ref#"; "WARNING")
checkIfNullString(->[LinkedDocs:4]TypeOfDoc:5; "Type of picture ID")

checkAddWarningOnTrue(isDateExpired([LinkedDocs:4]ExpiryDate:4); "Picture ID is expired")
checkAddWarningOnTrue((Picture size:C356([LinkedDocs:4]ScannedImage:2)=0); "There is no picture ID attached.")

checkIfModified(->[LinkedDocs:4]CustomerID:1; "You have reassigned the picture ID to another customer"; "WARN")

checkIfNullString(->[LinkedDocs:4]IssueCity:7; "City of Issue"; "WARN")
checkIfNullString(->[LinkedDocs:4]IssueCountry:8; "Country of Issue"; "WARN")

