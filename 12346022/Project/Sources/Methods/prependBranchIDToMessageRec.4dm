//%attributes = {}
PrependBranchPrefixTo(->[MESSAGES:11]MessageID:1; ->[MESSAGES:11]BranchID:18)
If ([MESSAGES:11]FromUserID:5#getSelfCustomerID)
	PrependBranchPrefixTo(->[MESSAGES:11]FromUserID:5)
End if 
If ([MESSAGES:11]toUserID:6#getSelfCustomerID)
	PrependBranchPrefixTo(->[MESSAGES:11]toUserID:6)
End if 

