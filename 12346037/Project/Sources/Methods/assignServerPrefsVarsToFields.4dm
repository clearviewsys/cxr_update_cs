//%attributes = {}
// assign the vars to the approprate field of same name as the gloval var (without the ◊ prefix)

// for example : <>smtpServer:=[serverPrefs]smtpServer

C_POINTER:C301($globalVarPtr)
C_LONGINT:C283($i)

C_BOOLEAN:C305($bIndexed; $bInvisible; $bUnique)
C_LONGINT:C283($i; $iLength; $iType; $iTable)

For ($i; 1; Get last field number:C255(->[ServerPrefs:27]))
	
	If (Is field number valid:C1000(->[ServerPrefs:27]; $i))  // Jan 16, 2012 18:21:21 -- I.Barclay Berry 
		
		$iTable:=Table:C252(->[ServerPrefs:27])
		
		GET FIELD PROPERTIES:C258($iTable; $i; $iType; $iLength; $bIndexed; $bUnique; $bInvisible)
		
		If ($bInvisible)
		Else 
			$globalVarPtr:=Get pointer:C304("<>"+Field name:C257(Table:C252(->[ServerPrefs:27]); $i))
			If (Is nil pointer:C315($globalVarPtr))
			Else 
				$globalVarPtr->:=Field:C253($iTable; $i)->  // assign the global vriable to the value of the field (same name)
			End if 
			
		End if 
		
	End if 
End for 