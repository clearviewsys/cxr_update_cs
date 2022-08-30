//%attributes = {}
checkIfNullString(->[MESSAGES:11]Subject:7; "Subject Line")
checkIfNullString(->[MESSAGES:11]MessageBody:8; "Message Body")
checkIfNullString(->[MESSAGES:11]FromUserID:5; "From User")
If ([MESSAGES:11]toUserID:6="")
	checkAddWarning("This message will be broadcasted to everyone.")
End if 

C_LONGINT:C283($found)
$found:=selectCustomerByID([MESSAGES:11]toUserID:6)
If (($found=1) & Not:C34([Customers:3]isAllowedInternetAccess:50))
	checkAddWarning([Customers:3]FullName:40+" is not setup for internet access.")
End if 