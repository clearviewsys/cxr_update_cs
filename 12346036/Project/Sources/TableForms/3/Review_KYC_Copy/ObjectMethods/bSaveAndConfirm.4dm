[Customers:3]ReviewDate:97:=Current date:C33
[Customers:3]ReviewedByUser:98:=getApplicationUser
// validateCustomers
C_POINTER:C301($notesPtr)
$notesPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "Description")
handleSaveButton(->[Customers:3]; ->[Customers:3]BranchID:86; ->[Customers:3]CreationDate:54; ->[Customers:3]CreationTime:55; ->[Customers:3]CreatedByUserID:58; ->[Customers:3]ModificationDate:56; ->[Customers:3]ModificationTime:57; ->[Customers:3]ModifiedByUserID:59; ->[Customers:3]modBranchID:111)
If (OK=1)
	createRecordKYC_ReviewLog([Customers:3]CustomerID:1; $notesPtr->)
End if 