//%attributes = {}
// Based on OBJ_ToRecord method by Cannon Smith from his OBJ Module

//Expects a record to be loaded in read/write mode in the passed in table. Sets each field
//from the passed in object. It is up to you to save the record, or to ensure it isn't a
//duplicate record, etc.

//When the values are placed into the record's fields, it is done based on the current field
//name and type. If the object contains a field name that isn't recognized by the table
//structure, it will be ignored. If the structure has fields that aren't in the object, they
//will not be touched at all.

C_OBJECT:C1216($1; $recordObj)  //Expects the record object to be passed in here
C_POINTER:C301($2; $tablePtr)
C_TEXT:C284($3; $codec)  //Optional. Used for picture fields. Extension (".png") or mime type ("image/jpeg")

$recordObj:=$1
$tablePtr:=$2
If (Count parameters:C259>2)
	$codec:=$3
Else 
	$codec:=".png"  //Default for picture fields
End if 

C_LONGINT:C283($i; $lastFieldNumber)
C_TEXT:C284($fieldName; $JSONValue)
C_POINTER:C301($fieldPtr)

If ($recordObj#Null:C1517)
	
	$lastFieldNumber:=Get last field number:C255($tablePtr)
	
	For ($i; 1; $lastFieldNumber)
		
		If (Is field number valid:C1000($tablePtr; $i)=True:C214)
			
			$fieldPtr:=Field:C253(Table:C252($tablePtr); $i)
			$fieldName:=Field name:C257($fieldPtr)
			
			
			If ($recordObj[$fieldName]#Null:C1517)
				
				Case of 
					: (Type:C295($fieldPtr->)=Is date:K8:7)
						$JSONValue:=OB Get:C1224($recordObj; $fieldName; Is text:K8:3)
						$fieldPtr->:=dateFromYYYYMMDD($JSONValue)
						
					: (Type:C295($fieldPtr->)=Is time:K8:8)
						$JSONValue:=OB Get:C1224($recordObj; $fieldName; Is text:K8:3)
						$fieldPtr->:=Time:C179($JSONValue)
						
					: (Type:C295($fieldPtr->)=Is picture:K8:10)
						$JSONValue:=OB Get:C1224($recordObj; $fieldName)
						CONVERT FROM TEXT:C1011($JSONValue; "US-ASCII"; $iBlob)
						BASE64 DECODE:C896($iBlob)
						BLOB TO PICTURE:C682($iBlob; $fieldPtr->; $codec)
						
					: (Type:C295($fieldPtr->)=Is BLOB:K8:12)
						$JSONValue:=OB Get:C1224($recordObj; $fieldName)
						CONVERT FROM TEXT:C1011($JSONValue; "US-ASCII"; $fieldPtr->)
						BASE64 DECODE:C896($fieldPtr->)
						
					Else 
						$fieldPtr->:=OB Get:C1224($recordObj; $fieldName)
						
				End case 
			End if 
			
		End if 
		
	End for 
	
End if 
