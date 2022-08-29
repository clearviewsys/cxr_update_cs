//%attributes = {}
C_TEXT:C284(vCustomerID)


If ([Accounts:9]AllowedOnlyByGroup:33#"")  // if account has a blue list, then make sure user is that blue list
	checkAddErrorIf(getCurrentUserGroup#[Accounts:9]AllowedOnlyByGroup:33; "This account is only restricted to group "+[Accounts:9]AllowedOnlyByGroup:33)
End if 

If ([Accounts:9]NotAllowedByGroup:34#"")  // if account has a red list, then make sure user is not in that red list
	checkAddErrorIf(getCurrentUserGroup=[Accounts:9]NotAllowedByGroup:34; "Sorry, this account cannot be accessed by group "+[Accounts:9]NotAllowedByGroup:34)
End if 

checkAddErrorIf((vCustomerID=getWalkInCustomerID) & [Accounts:9]doPreventWalkins:35; "This account is not allowed for walkin customers")
