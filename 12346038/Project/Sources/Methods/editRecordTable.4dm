//%attributes = {}
// editRecord
// this method is called from the tbar edit record button (tbar_modify)


C_POINTER:C301($tablePtr; $1)
$tablePtr:=$1
C_TEXT:C284($namedSelection; $form)
$namedSelection:=getTableNamedSelection($tablePtr)
$form:=getTableEntryFormName($tablePtr)

If (Not:C34(Is nil pointer:C315($tablePtr)))
	
	If (isUserAuthorizedToModify($tablePtr))
		C_LONGINT:C283($winRef)
		READ WRITE:C146($tablePtr->)
		
		LOAD RECORD:C52($tablePtr->)
		FORM SET INPUT:C55($tablePtr->; $form)
		
		COPY NAMED SELECTION:C331($tablePtr->; $namedSelection)
		
		START TRANSACTION:C239  //2/22/17
		
		If (Shift down:C543)
			$winRef:=Open form window:C675($tablePtr->; $form; Plain window:K34:13; Horizontally centered:K39:1; Vertically centered:K39:4)
		Else 
			$winRef:=Open form window:C675($tablePtr->; $form; Plain window:K34:13; Horizontally centered:K39:1; Vertically centered:K39:4; *)
		End if 
		
		DEFAULT TABLE:C46($tablePtr->)  //IBB 4/1/20
		
		MODIFY RECORD:C57($tablePtr->; *)  // the * hides the scrollbars according to the docs
		
		If (OK=1)
			VALIDATE TRANSACTION:C240  //2/22/17
			UNLOAD RECORD:C212($1->)  //<----- should this be below after the IF-ELSE-END IF ???
		Else 
			CANCEL TRANSACTION:C241  //2/22/17
		End if 
		
		CLOSE WINDOW:C154($winRef)
		
		UNLOAD RECORD:C212($tablePtr->)
		READ ONLY:C145($tablePtr->)
		LOAD RECORD:C52($tablePtr->)
		//
		USE NAMED SELECTION:C332($namedSelection)
		CLEAR NAMED SELECTION:C333($namedSelection)
		
	Else 
		myAlert("Modifications to "+getElegantTableName($tablePtr)+" not allowed.")
		//myAlert_AccessDenied
	End if 
End if 
