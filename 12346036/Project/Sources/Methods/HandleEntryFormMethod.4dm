//%attributes = {}
// handleEntryFormMethod (->table;->creatoruserID;->modifierUserID; ->branchIDField)
// handleentryform (->table; ->primaryKey)

// calls the validate<Table> method on load
// e.g. validateCustomers


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
		executeMethodName("validate"+Table name:C256($tablePtr))
		// validateTable
		SET MENU BAR:C67(1)
		setFormObjectCustomProperties
		//colourizeMandatoryTable ($tablePtr)
		//XLIFF_TranslateFormObjects 
		//setObjectShortcut 
		
	: ($event=On Unload:K2:2)
		//GET WINDOW RECT($xCord;$yCord;$r;$b)
		//SET WINDOW RECT(Current form table;$xCord;$yCord)
		
	: ($event=On Close Box:K2:21)
		If (Modified record:C314(Current form table:C627->))
			// Replaced on: 2/7/2017 BY: CVS Dev. Team
			// CONFIRM("Do you want to Save Before Closing?";"Save";"Don't Save")
			myConfirm(GetLocalizedErrorMessage(3984); getLocalizedKeyword("save"); getLocalizedKeyword("no_save"))
			If (OK=1)
				POST KEY:C465(Enter key:K12:26)
			Else 
				CANCEL:C270
			End if 
			
		Else 
			//CANCEL
		End if 
		
		If ($event=On Deactivate:K2:10)
			//BRING TO FRONT(Current process)
		End if 
		
End case 

