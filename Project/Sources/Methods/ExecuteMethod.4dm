//%attributes = {"shared":true}

C_TEXT:C284($command)
$command:=Request:C163("Enter 4D Command for Execution:")
If ($command#"")
	CONFIRM:C162("Are you sure you want to execute "+$command+"?")
	If (OK=1)
		EXECUTE METHOD:C1007($command)
	End if 
End if 