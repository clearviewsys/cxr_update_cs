
If (isUserAuthorizedToModify(->[Customers:3]))
	modifyRecordTable(->[Customers:3]; "Review_KYC")
Else 
	myAlert_AccessDenied
End if 