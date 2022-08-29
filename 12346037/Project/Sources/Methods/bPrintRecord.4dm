//%attributes = {"publishedWeb":true}
C_POINTER:C301($tablePtr; $1)
$tablePtr:=$1

If (isUserAuthorizedToPrint($tablePtr))
	C_LONGINT:C283($winRef)
	$winRef:=Open form window:C675([CompanyInfo:7]; "printReportTemplate")
	
	ARRAY TEXT:C222(vReportNames; 20)
	ARRAY TEXT:C222(vReportDesc; 20)
	C_POINTER:C301(currentTablePtr)
	currentTablePtr:=$tablePtr
	C_TEXT:C284($tableName)
	$tableName:=Table name:C256($tablePtr)
	LIST TO ARRAY:C288($tablename+"rep"; vReportnames)
	LIST TO ARRAY:C288($tablename+"repDesc"; vReportDesc)
	
	
	DIALOG:C40([CompanyInfo:7]; "printReportTemplate")
	
	CLOSE WINDOW:C154
Else 
	myAlert("You are not authorized to print records of this table.")
End if 