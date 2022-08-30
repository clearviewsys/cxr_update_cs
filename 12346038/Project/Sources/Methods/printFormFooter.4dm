//%attributes = {}
// printFormHeader(Title of form)
// use this to print a generic header

C_TEXT:C284(vFooterText; $1)

If (Count parameters:C259=1)
	vFooterText:=$1
Else 
	vFooterText:=""
End if 

Print form:C5([CompanyInfo:7]; "printFormFooter")
