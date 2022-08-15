//%attributes = {}
// updateTableUsingMethod(->table;methodName; bool: Allrecords;"progress update text")
// ex : updateTableUsingMethod (->[invoices];"setInvoiceAutoComment")

C_POINTER:C301($tablePtr; $1)
C_TEXT:C284($method; $2)
C_BOOLEAN:C305($3)
C_TEXT:C284($progressbarLabel)

$tablePtr:=$1
$method:=$2

If ($3)
	ALL RECORDS:C47($tablePtr->)
End if 

If (Count parameters:C259=4)
	$progressbarLabel:=$4
Else 
	$progressbarLabel:="Updating Record:"
End if 

If (Semaphore:C143(getSemaphoreName($tablePtr)))
	notifyAlert("Concurrent Updates Error"; Table name:C256($tablePtr)+" is being updated by another process at this time!"; 10)
Else 
	
	C_LONGINT:C283($progress)
	C_LONGINT:C283($i; $n)
	
	$n:=Records in selection:C76($tablePtr->)
	If ($n>0)
		
		READ WRITE:C146($tablePtr->)
		$progress:=launchProgressBar("Update in progress...")
		$i:=1
		Repeat 
			GOTO SELECTED RECORD:C245($tablePtr->; $i)
			//LOAD RECORD($tablePtr->)
			// do anything you wish in this section
			executeMethodName($method)
			SAVE RECORD:C53($tablePtr->)
			
			refreshProgressBar($progress; $i; $n)
			setProgressBarTitle($progress; $progressbarLabel+String:C10($i))
			$i:=$i+1
		Until (($i>$n) | (isProgressBarStopped($progress)))
		HIDE PROCESS:C324($progress)
		
		UNLOAD RECORD:C212($tablePtr->)
		READ ONLY:C145($tablePtr->)
		CLEAR SEMAPHORE:C144(getSemaphoreName($tablePtr))
	End if 
End if 
