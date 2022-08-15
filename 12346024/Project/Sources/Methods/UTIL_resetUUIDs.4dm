//%attributes = {}

C_LONGINT:C283($i)
C_POINTER:C301($fieldPtr)


CONFIRM:C162("Are you sure you want to update/reset ALL UUIDs for all Tables?")

If (OK=1)
	READ WRITE:C146(*)
	For ($i; 1; Get last table number:C254)
		
		If (Is table number valid:C999($i))
			$fieldPtr:=UTIL_getFieldPointer("["+Table name:C256($i)+"]UUID")
			
			If (Is nil pointer:C315($fieldPtr))
			Else 
				//APPLY TO SELECTION(Table($i)->;$fieldPtr->:=Generate UUID) // @tiran had to comment this as it was giving a compiler error
				
			End if 
		End if 
		
	End for 
End if 

READ ONLY:C145(*)