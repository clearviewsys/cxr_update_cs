//%attributes = {}
C_TEXT:C284($0; $rec)

$rec:=""
// appendLabelString (->var;label;stringToAppend;{doNewLine?})
appendLabelString(->$rec; "Customer ID:"; [Customers:3]CustomerID:1; True:C214)
appendLabelString(->$rec; "Full Name:"; [Customers:3]FullName:40; True:C214)
appendLabelString(->$rec; "Address:"; env_makeAddressText; True:C214)
appendLabelString(->$rec; "Main Phone:"; [Customers:3]HomeTel:6; True:C214)

If ([Customers:3]isCompany:41)
	appendLabelString(->$rec; "Incorporation #:"; [Customers:3]BusinessIncorporationNo:65; True:C214)
	
	
Else 
	appendLabelString(->$rec; "Picture ID:"; [Customers:3]PictureID_Number:69; True:C214)
	appendLabelString(->$rec; "Issued In:"; [Customers:3]PictureID_IssueState:72; True:C214)
	appendLabelString(->$rec; "Expirey Date:"; String:C10([Customers:3]PictureID_ExpiryDate:71); True:C214)
	
End if 
$0:=$rec
