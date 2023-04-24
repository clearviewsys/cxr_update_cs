//%attributes = {}

C_LONGINT:C283(slb_Picker)
C_TEXT:C284(vSearchText)
checkInit
checkAddWarningOnTrue([Countries:62]RiskLevel:5=2; "Caution: This Country is Medium Risk."+CRLF+[Countries:62]RiskDetail:6)
checkAddWarningOnTrue([Countries:62]RiskLevel:5=3; "AML Warning: This Country is identified as high risk. Make sure you do additional due diligence"+CRLF+[Countries:62]RiskDetail:6)
checkAddWarningOnTrue([Countries:62]isSanctioned:7; "AML Warning: This country is under international sanction")


If (isValidationConfirmed)
	handlePickButton(->[Countries:62]; ->[Countries:62]CountryCode:1; ->slb_Picker; ->vSearchText)
Else 
	REJECT:C38
End if 