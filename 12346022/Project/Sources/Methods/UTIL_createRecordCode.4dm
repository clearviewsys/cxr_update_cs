//%attributes = {}




C_POINTER:C301($1; $ptrTable)
C_TEXT:C284($tResult)

C_LONGINT:C283($iTableCount; $i; $iElem)

If (Count parameters:C259>=1)
	$ptrTable:=$1
	OK:=1
Else 
	ARRAY TEXT:C222($atTable; 0)
	ARRAY LONGINT:C221($aiTable; 0)
	
	$iTableCount:=Get last table number:C254
	
	For ($i; 1; $iTableCount)
		If (Is table number valid:C999($i))
			APPEND TO ARRAY:C911($atTable; Table name:C256($i))
			APPEND TO ARRAY:C911($aiTable; $i)
		End if 
	End for 
	
	SORT ARRAY:C229($atTable; $aiTable; >)
	
	$iElem:=choiceList("pick a table"; ->$atTable)
	
	If (ok=1)
		$ptrTable:=Table:C252($aiTable{$iElem})
	End if 
End if 

$tResult:=""

If (OK=1)
	For ($i; 1; Get last field number:C255($ptrTable))
		
		If (Is field number valid:C1000($ptrTable; $i))
			$tResult:=$tResult+"["+Table name:C256($ptrTable)+"]"+Field name:C257(Table:C252($ptrTable); $i)+":="+Char:C90(Carriage return:K15:38)
		End if 
		
	End for 
	
	SET TEXT TO PASTEBOARD:C523($tResult)
End if 


BEEP:C151