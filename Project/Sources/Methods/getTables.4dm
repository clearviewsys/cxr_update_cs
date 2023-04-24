//%attributes = {}
C_POINTER:C301($1; $2)
C_BOOLEAN:C305($includeinvisible; $invisible)
C_LONGINT:C283($i; $n)

$includeinvisible:=True:C214


If (Count parameters:C259=3)
	C_BOOLEAN:C305($3)
	$includeinvisible:=$3
End if 

$n:=Get last table number:C254
For ($i; 1; $n)
	
	If (Is table number valid:C999($i))
		
		If ($includeinvisible)
			APPEND TO ARRAY:C911($2->; Table name:C256($i))
			APPEND TO ARRAY:C911($1->; $i)
			
		Else 
			// Do not include invisible
			GET TABLE PROPERTIES:C687($i; $invisible)
			
			If ($invisible)
				// Do nothing
			Else 
				APPEND TO ARRAY:C911($2->; Table name:C256($i))
				APPEND TO ARRAY:C911($1->; $i)
			End if 
			
		End if 
		
	End if 
	
End for 

