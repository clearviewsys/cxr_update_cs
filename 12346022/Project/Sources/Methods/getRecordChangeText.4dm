//%attributes = {"shared":true,"publishedWeb":true}
//currenly used in emails

C_POINTER:C301($1; $ptrTable)
C_LONGINT:C283($2; $mode)

C_TEXT:C284($0)

If (Count parameters:C259>=1)
	$ptrTable:=$1
Else 
	$ptrTable:=EMAIL_tablePtr
End if 

If (Is nil pointer:C315($ptrTable))
	$ptrTable:=EMAIL_tablePtr
End if 

If (Count parameters:C259>=2)
	$mode:=$2
Else 
	$mode:=1
End if 


If (True:C214)
	$0:=UTIL_recordChangeToText($ptrTable; $mode)
Else 
	$0:=Char:C90(1)+UTIL_recordChangeToText($ptrTable; $mode)
End if 