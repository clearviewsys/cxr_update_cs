//%attributes = {}

C_POINTER:C301($ptrField)
C_LONGINT:C283($iProgress; $i; $iNumTables; $iPercent; $i; $ii)

$iNumTables:=Get last table number:C254

$iProgress:=Progress New

For ($i; 1; $iNumTables)
	If (Is table number valid:C999($i))
		
		$iPercent:=$i/$iNumTables
		Progress SET PROGRESS($iProgress; $iPercent; "Fixing UUIDs in "+Table name:C256($i))
		
		
		$ptrField:=UTIL_getFieldPointer("["+Table name:C256($i)+"]UUID")
		
		If (Is nil pointer:C315($ptrField))
		Else 
			
			READ WRITE:C146(Table:C252($i)->)
			QUERY BY FORMULA:C48(Table:C252($i)->; UTIL_UUID_is_Null($ptrField->))
			
			For ($ii; 1; Records in selection:C76(Table:C252($i)->))
				$ptrField->:=Generate UUID:C1066
				SAVE RECORD:C53(Table:C252($i)->)
				NEXT RECORD:C51(Table:C252($i)->)
			End for 
			
		End if 
		
	End if 
	
End for 

Progress QUIT($iProgress)