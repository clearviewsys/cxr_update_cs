//%attributes = {}
C_POINTER:C301($tablePtr; $1)
C_BOOLEAN:C305($2; $bUseNewMode)
C_POINTER:C301($0)

C_TEXT:C284($tFieldName; $tTableName)
C_POINTER:C301($ptrField)

$tablePtr:=$1

If (Count parameters:C259>=2)
	$bUseNewMode:=$2
Else 
	$bUseNewMode:=False:C215
End if 

If ($bUseNewMode)
	$tTableName:=Table name:C256($tablePtr)
	$tFieldName:="["+$tTableName+"]"
	If (Substring:C12($tTableName; Length:C16($tTableName); 1)="s")  //ends with s
		$tFieldName:=$tFieldName+Substring:C12($tTableName; 1; Length:C16($tTableName)-1)+"ID"
	Else 
		$tFieldName:=$tFieldName+$tTableName+"ID"
	End if 
	$ptrField:=UTIL_getFieldPointer($tFieldName)
	
Else 
	$ptrField:=Field:C253(Table:C252($tablePtr); 1)
End if 

$0:=$ptrField