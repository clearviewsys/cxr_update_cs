C_LONGINT:C283(vCount)
handleListBoxFormMethod(Current form table:C627; ->vCount)

C_LONGINT:C283($i; $n)
C_LONGINT:C283($progress)

If (Form event code:C388=On Load:K2:1)
	SET TIMER:C645(200)  // update the numbers after a second or so
End if 


If (Form event code:C388=On Timer:K2:25)
	
	//ALL RECORDS([MainAccounts])
	
	
	READ WRITE:C146([MainAccounts:28])
	$progress:=launchProgressBar("Calculating...")
	$n:=Records in selection:C76([MainAccounts:28])
	
	For ($i; 1; $n)
		
		GOTO SELECTED RECORD:C245([MainAccounts:28]; $i)
		LOAD RECORD:C52([MainAccounts:28])
		relateMany(->[Accounts:9]; ->[Accounts:9]MainAccountID:2; ->[MainAccounts:28]MainAccountID:1)
		RELATE MANY SELECTION:C340([Registers:10]AccountID:6)  // then select the related registers
		
		If (cbApplyDateRange=1)
			selectDateRangeTable(->[Registers:10]; ->[Registers:10]RegisterDate:2; vFromDate; vToDate)
		End if 
		
		setProgressBarTitle($progress; [MainAccounts:28]MainAccountID:1)
		getRegisterSums(->[MainAccounts:28]DebitBalance:8; ->[MainAccounts:28]CreditBalance:9; ->[MainAccounts:28]Balance:11; ->[MainAccounts:28]Fees:10; ->[MainAccounts:28]UnrealizedGain:12)
		refreshProgressBar($progress; $i; $n)
		
		SAVE RECORD:C53([MainAccounts:28])
		UNLOAD RECORD:C212([MainAccounts:28])
		If (In transaction:C397)
			VALIDATE TRANSACTION:C240
			TM_RemoveFromStack  //9/15/16
		End if 
		
	End for 
	READ ONLY:C145([MainAccounts:28])
	// SET TIMER(5000)
	
	SET TIMER:C645(0)
	HIDE PROCESS:C324($progress)
	REDRAW:C174(mainListBox)
	
End if 
