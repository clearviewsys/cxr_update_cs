//%attributes = {}
// export all index fields to a file

C_TEXT:C284($1; $tPath)
C_TEXT:C284($2; $sName)
C_LONGINT:C283($vType; $vLen)

If (Count parameters:C259>=1)
	$tPath:=$1
Else 
	$tPath:=""
End if 


C_TEXT:C284($tableName; $fieldName; $fieldType)
C_LONGINT:C283($tableNumber; $fieldNumber)
C_BOOLEAN:C305($isIndexed)


CONFIRM:C162("Step 1: Create Structure Dictionary")
C_LONGINT:C283($n)

If (OK=1)
	Doc:=Create document:C266($tPath+$sName)  //"Struct_Dict.txt")
	
	For ($tableNumber; 1; Get last table number:C254)
		
		$tableName:=Table name:C256($tableNumber)
		
		$n:=Get last field number:C255($tableNumber)
		For ($fieldNumber; 1; $n)
			
			$fieldName:=Field name:C257($tableNumber; $fieldNumber)
			GET FIELD PROPERTIES:C258($tableNumber; $fieldNumber; $vType; $vLen; $isIndexed)
			
			If ($isIndexed)
				SEND PACKET:C103(Doc; "SetIndex(->["+$tableName+"]"+$fieldName+")"+CRLF)  // Modified by: tdc 1/29/99 adding record count
			End if 
			
		End for   //... Field Number
		
	End for   //... tables
	
	CLOSE DOCUMENT:C267(Doc)
	
	myAlert("Data structure is exported.")
	
End if   //... Doc