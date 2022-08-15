C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388

If ($formEvent=On Clicked:K2:4)
	
	If ([Wires:8]isBeneficiaryEntity:71)
		GOTO OBJECT:C206([Wires:8]BeneficiaryFullName:10)
	Else 
		GOTO OBJECT:C206([Wires:8]BeneficiaryGender:72)
	End if 
	
End if 


