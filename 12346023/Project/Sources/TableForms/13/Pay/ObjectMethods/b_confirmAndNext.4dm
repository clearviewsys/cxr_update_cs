checkInit
checkIfNullString(->[eWires:13]toCountryCode:112; "Destination Country Code")
checkIfNullString(->[eWires:13]toCountry:10; "Destination Country")
checkIfNullString(->[eWires:13]AgentID:26; "Remittance Agent")
checkIfNullString(->[eWires:13]AccountID:30; "Sub-Ledger Account")

If (isValidationConfirmed)
	FORM NEXT PAGE:C248
Else 
	REJECT:C38
End if 