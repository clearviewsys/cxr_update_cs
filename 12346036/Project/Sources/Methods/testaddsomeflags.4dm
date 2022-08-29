//%attributes = {}
C_LONGINT:C283($i)

DEFAULT TABLE:C46([Flags:19])
ALL RECORDS:C47

READ WRITE:C146
For ($i; 1; Records in selection:C76)
	loadPictureResource("flag_"+[Flags:19]CurrencyCode:1; ->[Flags:19]flag:4)
	//GET PICTURE FROM LIBRARY("flag_"+[Flags]CurrencyCode; [Flags]flag)
	SAVE RECORD:C53
	NEXT RECORD:C51
End for 
UNLOAD RECORD:C212
READ ONLY:C145