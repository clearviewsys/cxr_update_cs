//%attributes = {}
// printFormHeader(Title of form)
// use this to print a generic header

C_TEXT:C284(vDateTime; vReportTitle; $1)
C_TEXT:C284(vTerminalName)

If (Count parameters:C259=1)
	vReportTitle:=$1
Else 
	vReportTitle:=""
End if 
vTerminalName:=getCurrentMachineName

vDateTime:="Printed on "+getDateStampString+" by "+getApplicationUser
Print form:C5([CompanyInfo:7]; "printFormHeader")
