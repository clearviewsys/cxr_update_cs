//%attributes = {}
C_POINTER:C301($1)  //table

C_POINTER:C301($ptrNull; $ptrField)

C_TEXT:C284(EMAIL_tableName)
C_TEXT:C284(EMAIL_recordID)
C_POINTER:C301(EMAIL_tablePtr)


If (Count parameters:C259>=1)
	EMAIL_tableName:=Table name:C256($1)
	EMAIL_tablePtr:=$1
	$ptrField:=UTIL_getFieldPointer("["+EMAIL_tableName+"]"+Substring:C12(EMAIL_tableName; 1; Length:C16(EMAIL_tableName)-1)+"ID")
	If (Is nil pointer:C315($ptrField))
		EMAIL_recordID:="UNKNOWN"
	Else 
		EMAIL_recordID:=$ptrField->
	End if 
	
Else 
	EMAIL_tableName:="NULL"
	EMAIL_tablePtr:=$ptrNull
	EMAIL_recordID:="NULL"
End if 