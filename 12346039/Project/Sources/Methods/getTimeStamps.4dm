//%attributes = {}

//getTimeStamps (->$arrText; ->$arrTimestamps)

C_POINTER:C301($1; $tablePtr; $2; $arrFieldNamesPtr; $3; $arrFieldTSPtr; $4; $arrFieldValPtr)
C_LONGINT:C283($fieldNumber)

Case of 
		
	: (Count parameters:C259=4)
		$tablePtr:=$1
		$arrFieldNamesPtr:=$2
		$arrFieldTSPtr:=$3
		$arrFieldValPtr:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_LONGINT:C283($i)
C_POINTER:C301($ptr)
ARRAY TEXT:C222($arrRef; 0)

C_TEXT:C284($encoded; $tsMaster; $t; $ts; $fieldName)
C_LONGINT:C283($fieldNumber)
C_OBJECT:C1216($obj)

$t:=XB_BlobToBag([Customers:3]_Sync_Data:95)
XB_GetAllItems($t; ->$arrRef)

For ($i; 1; Size of array:C274($arrRef))
	
	If (isAValidField($arrRef{$i}))
		
		$fieldName:=Replace string:C233($arrRef{$i}; "field_timestamp."; "")
		$fieldNumber:=getFieldNumber($tablePtr; $fieldName)
		
		If ($fieldNumber#-1)
			
			APPEND TO ARRAY:C911($arrFieldNamesPtr->; $fieldName)
			
			$encoded:=XB_GetText($t; $arrRef{$i})
			$ts:=Sync_TimeStamp("decode"; $encoded)
			APPEND TO ARRAY:C911($arrFieldTSPtr->; $ts)
			
			$ptr:=getFieldPointer($tablePtr; $fieldName)
			$obj:=New object:C1471
			$obj.value:=OB Get:C1224(convert2Object($ptr); "value")
			
			APPEND TO ARRAY:C911($arrFieldValPtr->; convert2String($obj))
			
		End if 
		
		
	End if   //If (isAValidField ($arrFieldNamesPtr->{$i})
	
End for 