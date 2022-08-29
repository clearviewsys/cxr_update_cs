//%attributes = {}
// handleApplyBRToCustomersButton
// getBuild

C_LONGINT:C283($i; $n)
C_POINTER:C301($tablePtr)
C_LONGINT:C283($progress)
$tablePtr:=->[Customers:3]

If (getKeyValue("AMLRule.License")="Pro")
	If (Form event code:C388=On Clicked:K2:4)
		
		$n:=Records in selection:C76([Customers:3])
		myConfirm("Are you sure you want to auto-assign Start of Business Relationship?"; "Apply"; "Cancel"; "Business Relationship")
		If (OK=1)
			READ WRITE:C146($tablePtr->)
			$progress:=launchProgressBar("Calculationg Business Relationship Date...")
			$n:=Records in selection:C76($tablePtr->)
			$i:=1
			
			FIRST RECORD:C50($tablePtr->)
			Repeat 
				LOAD RECORD:C52($tablePtr->)
				setCustomerBusRelationFields([Customers:3]CustomerID:1)
				SAVE RECORD:C53($tablePtr->)
				
				NEXT RECORD:C51($tablePtr->)
				
				refreshProgressBar($progress; $i; $n)
				setProgressBarTitle($progress; "Applying to record :"+[Customers:3]CustomerID:1)
				$i:=$i+1
			Until (($i>$n) | (isProgressBarStopped($progress)))
			HIDE PROCESS:C324($progress)
		End if 
		
	End if 
	
Else 
	myAlert("This function requires a Professional AML Engine license (AMLRule.License)")
End if 