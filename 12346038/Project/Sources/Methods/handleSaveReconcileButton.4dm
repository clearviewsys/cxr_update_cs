//%attributes = {}
$n:=Size of array:C274(arrDates)

checkInit
If (In transaction:C397)
	checkAddWarning("WARNING. You are currently inside a transaction. Make sure you save the parent transaction or your data will be lost.")
End if 
C_LONGINT:C283($total; $i)
If (isValidationConfirmed)
	READ WRITE:C146([Registers:10])
	COPY NAMED SELECTION:C331([Registers:10]; "$registersSnapshot")
	CREATE EMPTY SET:C140([Registers:10]; "$lockedRegisters")
	//SORT ARRAY(arrRegisterIDs;arrChecked;arrValidation;arrValidator)
	//ORDER BY([Registers];[Registers]RegisterID)
	//ARRAY TO SELECTION(arrChecked;[Registers]isValidated;arrValidation;[Registers]validationCode;arrValidator;[Registers]validatedByUserID)
	C_LONGINT:C283($progress; $n)
	$progress:=launchProgressBar("Reconciliation...")
	$total:=Size of array:C274(arrRegisterIDs)
	BRING TO FRONT:C326($progress)
	
	For ($i; 1; $total)
		If (arrChecked{$i}#arrOldChecked{$i})  // something has changed in the record
			QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=arrRegisterIDs{$i})  // find the associated record
			If (Locked:C147([Registers:10]))
				ADD TO SET:C119([Registers:10]; "$lockedRegisters")
			Else 
				LOAD RECORD:C52([Registers:10])
				ASSERT:C1129([Registers:10]RegisterID:1=arrRegisterIDs{$i})
				[Registers:10]validationCode:36:=arrValidation{$i}
				[Registers:10]isValidated:35:=arrChecked{$i}
				[Registers:10]validatedByUserID:37:=arrValidator{$i}
				refreshProgressBar($progress; $i; $total)
				//DELAY PROCESS(Current process;1)
				SAVE RECORD:C53([Registers:10])
				
				setProgressBarTitle($progress; "Register: "+arrRegisterIDs{$i}+" Validation: "+arrValidation{$i})
			End if 
		Else   // 
			refreshProgressBar($progress; $i; $total)
			setProgressBarTitle($progress; "skipping: "+arrRegisterIDs{$i})
			//
		End if 
	End for 
	
	
	HIDE PROCESS:C324($progress)
	
	If (Records in set:C195("$lockedRegisters")>0)
		myAlert(String:C10(Records in set:C195("$lockedRegisters"))+" records were locked and were not updated during save.")
		USE NAMED SELECTION:C332("$registersSnapshot")
		CLEAR NAMED SELECTION:C333("$registersSnapshot")
		CLEAR SET:C117("$lockedRegisters")
		READ ONLY:C145([Registers:10])
		
		REJECT:C38
	Else 
		USE NAMED SELECTION:C332("$registersSnapshot")
		CLEAR NAMED SELECTION:C333("$registersSnapshot")
		CLEAR SET:C117("$lockedRegisters")
		READ ONLY:C145([Registers:10])
	End if 
	
End if 

If (In transaction:C397)
	CONFIRM:C162("Save the trasaction?")
	If (OK=1)
		VALIDATE TRANSACTION:C240
		TM_RemoveFromStack  //9/15/16
	End if 
End if 