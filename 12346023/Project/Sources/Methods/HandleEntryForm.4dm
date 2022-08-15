//%attributes = {"publishedWeb":true}
// handleEntryForm (->table;->creatoruserID;->modifierUserID; ->branchIDField)
// handleentryform (->table; ->primaryKey)

C_POINTER:C301($tablePtr; $1; $2; $3; $4; $5)
C_LONGINT:C283($event)
C_BOOLEAN:C305(DataChanged)

$tablePtr:=Current form table:C627
$event:=Form event code:C388

Case of 
	: (Count parameters:C259=1)
		$tablePtr:=$1
		
	: (Count parameters:C259=3)
		setApplicationUserForTable($1; $2; $3)
		
	: (Count parameters:C259=4)
		setApplicationUserForTable($1; $2; $3; $4)
		
	: (Count parameters:C259=5)
		setApplicationUserForTable($1; $2; $3; $4; $5)
		
End case 


Case of 
	: ($event=On Load:K2:1)
		
		SET MENU BAR:C67(1)
		colourizeMandatoryTable($tablePtr)
		setFormObjectCustomProperties
		
		OBJECT SET ENABLED:C1123(bUpdate; False:C215)  //12/8/17 added IBB
		
	: ($event=On Outside Call:K2:11)
		If (Modified record:C314(Current form table:C627->))
			OBJECT SET ENABLED:C1123(bUpdate; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(bUpdate; False:C215)
		End if 
		
	: (Form event code:C388=On After Keystroke:K2:26) | (Form event code:C388=On Clicked:K2:4)
		If (Modified record:C314(Current form table:C627->))
			OBJECT SET ENABLED:C1123(bUpdate; True:C214)
		End if 
		
	: ($event=On Unload:K2:2)
		//GET WINDOW RECT($xCord;$yCord;$r;$b)
		//SET WINDOW RECT(Current form table;$xCord;$yCord)
		
	: ($event=On Close Box:K2:21)
		If (Modified record:C314(Current form table:C627->))
			CONFIRM:C162("Do you want to Save Before Closing?"; "Save"; "Don't Save")
			If (OK=1)
				POST KEY:C465(Enter key:K12:26)
			Else 
				CANCEL:C270
			End if 
			
		Else 
			CANCEL:C270
		End if 
		
		If ($event=On Deactivate:K2:10)
			//BRING TO FRONT(Current process)
		End if 
		
End case 


