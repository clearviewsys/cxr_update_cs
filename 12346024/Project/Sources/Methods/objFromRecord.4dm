//%attributes = {}
// based on OBJ_FromRecord mwthod by Cannon Smith from his OBJ module

//Expects a record to be loaded in the passed in table. Returns an object that contains each
//field and its value.

C_POINTER:C301($1; $tablePtr)
C_TEXT:C284($2; $codec)  //Optional. Used for picture fields. Extension (".png") or mime type ("image/jpeg")
C_OBJECT:C1216($0; $recordObj)

$tablePtr:=$1
If (Count parameters:C259>1)
	$codec:=$2
Else 
	$codec:=".png"  //Default for picture fields
End if 

C_LONGINT:C283($i; $lastFieldNumber)
C_TEXT:C284($fieldName; $convertedValue)
C_POINTER:C301($fieldPtr)
C_BLOB:C604($blob)

$recordObj:=New object:C1471

$lastFieldNumber:=Get last field number:C255($tablePtr)
For ($i; 1; $lastFieldNumber)
	If (Is field number valid:C1000($tablePtr; $i)=True:C214)
		$fieldPtr:=Field:C253(Table:C252($tablePtr); $i)
		$fieldName:=Field name:C257($fieldPtr)
		Case of 
			: (Type:C295($fieldPtr->)=Is date:K8:7)
				$convertedValue:=String:C10(Year of:C25($fieldPtr->); "0000")+"-"+\
					String:C10(Month of:C24($fieldPtr->); "00")+"-"+\
					String:C10(Day of:C23($fieldPtr->); "00")
				OB SET:C1220($recordObj; $fieldName; $convertedValue)
				
			: (Type:C295($fieldPtr->)=Is time:K8:8)
				$convertedValue:=String:C10(($fieldPtr->+0)\3600; "00")+":"+\
					String:C10((($fieldPtr->+0)\60)%60; "00")+":"+\
					String:C10(($fieldPtr->+0)%60; "00")
				OB SET:C1220($recordObj; $fieldName; $convertedValue)
				
			: (Type:C295($fieldPtr->)=Is picture:K8:10)
				PICTURE TO BLOB:C692($fieldPtr->; $blob; $codec)
				BASE64 ENCODE:C895($blob)
				$convertedValue:=Convert to text:C1012($blob; "US-ASCII")
				OB SET:C1220($recordObj; $fieldName; $convertedValue)
				
			: (Type:C295($fieldPtr->)=Is BLOB:K8:12)
				$blob:=$fieldPtr->  //Copy so we don't mess with the original record
				BASE64 ENCODE:C895($blob)
				$convertedValue:=Convert to text:C1012($blob; "US-ASCII")
				OB SET:C1220($recordObj; $fieldName; $convertedValue)
				
			Else 
				
				OB SET:C1220($recordObj; $fieldName; $fieldPtr->)
				
		End case 
	End if 
End for 

$0:=$recordObj
