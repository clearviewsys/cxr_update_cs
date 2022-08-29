//%attributes = {}

C_POINTER:C301($1)
C_POINTER:C301($0; $ptrPK)


C_TEXT:C284($tTableFieldName)


$tTableFieldName:=Table name:C256($1)
If (Substring:C12($tTableFieldName; Length:C16($tTableFieldName); 1)="s")  //pluralized
	$tTableFieldName:=Substring:C12($tTableFieldName; 1; Length:C16($tTableFieldName)-1)
End if 
$tTableFieldName:="["+Table name:C256($1)+"]"+$tTableFieldName+"ID"
$ptrPK:=UTIL_getFieldPointer($tTableFieldName)

If (Is nil pointer:C315($ptrPK))
	$ptrPK:=UTIL_getFieldPointer("["+Table name:C256($1)+"]UUID")
End if 


$0:=$ptrPK