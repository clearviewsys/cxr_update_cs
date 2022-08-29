//%attributes = {"publishedWeb":true}
// handleModifyForm

// call thid method for inside your "Modify" form methods

// Author: Tiran Behrouz

// Dec 24th,2002


C_POINTER:C301($table)
C_LONGINT:C283($event)
C_BOOLEAN:C305($DataChanged)
C_LONGINT:C283($xCord; $yCord; $r; $b)

$table:=Current form table:C627
$event:=Form event code:C388

//Handle VRecNum 


Case of 
	: ($event=On Load:K2:1)
		SET MENU BAR:C67(1)
		$dataChanged:=False:C215
		
	: ($event=On Unload:K2:2)
		GET WINDOW RECT:C443($xCord; $yCord; $r; $b)
		//set Cord (Current form table;$xCord;$yCord)
		
		
		
	: ($event=On Data Change:K2:15)
		
	: ($event=On Close Box:K2:21)
		If (Modified record:C314($table->))
			// the reason i have disactivated the above if statement
			
			// is that sometime you may modify a related table field 
			
			CONFIRM:C162("Save changes to the current record?"; "Save"; "Don't Save")
			If (OK=1)
				//If (In transaction)
				//validatetransaction
				//End if 
				ACCEPT:C269
			Else 
				//If (In transaction)
				//canceltransaction
				//End if 
				CANCEL:C270
			End if 
		Else 
			CANCEL:C270
		End if 
		POST OUTSIDE CALL:C329(-1)
End case 
