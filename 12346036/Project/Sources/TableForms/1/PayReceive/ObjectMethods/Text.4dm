
//pickCurrency (->[Cheques]Currency)
If ([Cheques:1]Currency:9="")
	pickCurrency(->[Cheques:1])
End if 
If ([Cheques:1]Currency:9#"")
	pickReceiveChequeAccountID(Self:C308; [Cheques:1]Currency:9)
End if 

C_POINTER:C301($subAccountPtr)
$subAccountPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "subAccountID")
handleDropDown_SubAccount($subAccountPtr; ->[Cheques:1]SubAccountID:29; [Cheques:1]AccountID:7; True:C214)