If ([MESSAGES:11]isMessageSent:14)
	OBJECT SET VISIBLE:C603(*; "bMessageRead"; False:C215)
Else 
	OBJECT SET VISIBLE:C603(*; "bMessageRead"; True:C214)
	
End if 

If (onViewEvents)
	C_TEXT:C284(vfromUserID; vToUserID)
	vFromUserID:=getCustomerFullName([MESSAGES:11]FromUserID:5)
	vToUserID:=getCustomerFullName([MESSAGES:11]toUserID:6)
End if 