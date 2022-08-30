//%attributes = {"shared":true}
C_TEXT:C284($1; vHelpRequest)
If (Count parameters:C259=1)
	vHelpRequest:=$1
End if 

openFormWindow(->[CompanyInfo:7]; "HelpRequestForm")
