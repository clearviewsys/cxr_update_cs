//%attributes = {}
C_LONGINT:C283($i)
READ ONLY:C145([Flags:19])
FIRST RECORD:C50([Flags:19])
C_TEXT:C284($fileName; $path)
For ($i; 1; Records in selection:C76([Flags:19]))
	LOAD RECORD:C52([Flags:19])
	$path:=getWebFolderPath+"Flags"+pathSeparator
	$fileName:=[Flags:19]CurrencyCode:1+".JPG"
	WRITE PICTURE FILE:C680($path+$fileName; [Flags:19]flag:4; "JPEG")
	UNLOAD RECORD:C212([Flags:19])
	NEXT RECORD:C51([Flags:19])
End for 