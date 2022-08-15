//%attributes = {}
// handleEntryForm_old

C_POINTER:C301($tablePtr; $1)
C_LONGINT:C283($event)
C_BOOLEAN:C305(DataChanged)

$tablePtr:=Current form table:C627
$event:=Form event code:C388



Case of 
	: ($event=On Load:K2:1)
		//starttransaction
		SET MENU BAR:C67(1)
		colourizeMandatoryTable($tablePtr)
	: ($event=On Validate:K2:3)
		//validatetransaction
		//  set Cord(Current form table;$xCord;$yCord)
		
		
	: ($event=On Unload:K2:2)
		//GET WINDOW RECT($xCord;$yCord;$r;$b)
		//set Cord (Current form table;$xCord;$yCord)
		//canceltransaction
		
	: ($event=On Close Box:K2:21)
		If (Modified record:C314(Current form table:C627->))
			CONFIRM:C162("Do you want to Save Before Closing?"; "Save"; "Don't Save")
			If (OK=1)
				POST KEY:C465(Enter key:K12:26)
			Else 
				//If (In transaction) // disabled by: Barclay Berry (2/24/13) per Tiran
				//canceltransaction
				//End if 
				CANCEL:C270
			End if 
		Else 
			//If (In transaction) // disabled by: Barclay Berry (2/24/13) per Tiran
			//canceltransaction
			//End if 
			CANCEL:C270
		End if 
		
End case 


