//%attributes = {}
C_TEXT:C284($accountID)
pickAccounts(->$accountID; "allrecordsAccounts"; "Pick an account to reconcile")
requestDateRange

If (OK=1)
	CONFIRM:C162("Automatically reconcile all records during the date range for account "+$accountID+"?")
	
	If (OK=1)
		selectRegistersInDateRange($accountID; vFromDate; vToDate)
		
		C_LONGINT:C283($progress)
		C_LONGINT:C283($i; $n)
		C_POINTER:C301($tablePtr)
		
		$tablePtr:=->[Registers:10]  // change this table to any table that you are working on
		
		$progress:=launchProgressBar("Validating ...")
		$n:=Records in selection:C76($tablePtr->)
		$i:=1
		
		READ WRITE:C146($tablePtr->)
		FIRST RECORD:C50($tablePtr->)
		Repeat 
			LOAD RECORD:C52($tablePtr->)
			// do anything you wish in this section
			[Registers:10]validatedByUserID:37:=getApplicationUser
			[Registers:10]validationCode:36:="auto"
			[Registers:10]isValidated:35:=True:C214
			SAVE RECORD:C53($tablePtr->)
			NEXT RECORD:C51($tablePtr->)
			
			refreshProgressBar($progress; $i; $n)
			setProgressBarTitle($progress; "Validating :"+String:C10($i))
			$i:=$i+1
		Until (($i>$n) | (isProgressBarStopped($progress)))
		HIDE PROCESS:C324($progress)
		READ ONLY:C145($tablePtr->)
	End if 
End if 
