//%attributes = {}
// to fix records getting locked
// 1/11/21 IBB

C_POINTER:C301($1)  // main table in use

C_LONGINT:C283($i)
C_POINTER:C301($ptrTable)

For ($i; 1; Get last table number:C254)
	If (Is table number valid:C999($i))
		$ptrTable:=Table:C252($i)
		
		If (Records in selection:C76($ptrTable->)>0)
			//If (Locked($ptrTable->))
			//UNLOAD RECORD($ptrTable->)
			//End if 
			
			UNLOAD RECORD:C212($ptrTable->)
			
			READ ONLY:C145($ptrTable->)
			
			If (True:C214)
				LOAD RECORD:C52($ptrTable->)
			Else 
				If ($ptrTable=$1)
					LOAD RECORD:C52($ptrTable->)
				Else 
					REDUCE SELECTION:C351($ptrTable->; 0)
				End if 
			End if 
			
		End if 
		
	End if 
End for 