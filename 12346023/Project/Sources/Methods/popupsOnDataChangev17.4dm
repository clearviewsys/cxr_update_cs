//%attributes = {}
// call this method from form method during On Data Change phase

C_TEXT:C284($1; $formObjectProperty)  // which property holds data to be displayed in popups
C_OBJECT:C1216($dummy)
C_POINTER:C301($objptr)
C_OBJECT:C1216($0)
C_TEXT:C284($methodToExecute)
C_POINTER:C301($objptr)

$formObjectProperty:=$1

If (Form:C1466[$formObjectProperty].selected#Null:C1517)
	
	
	If (Form:C1466[$formObjectProperty][Form:C1466[$formObjectProperty].selected]#Null:C1517)
		
		// one of our popups invoked event
		
		popupsExecuteMethod($formObjectProperty; Form:C1466[$formObjectProperty].selected)
		
	End if 
	
End if 

Form:C1466[$formObjectProperty].selected:=Null:C1517
