//%attributes = {}
// maketDailyExportPath (->table)
C_POINTER:C301($tablePtr; $1)
C_TEXT:C284($path; $0)
C_DATE:C307($date)
C_TEXT:C284($dateStr)

If (Count parameters:C259=0)
	$tablePtr:=->[Registers:10]
Else 
	$tablePtr:=$1
End if 


$date:=Current date:C33
$dateStr:=String:C10(Year of:C25($date))+String:C10(Month of:C24($date); "00")+String:C10(Day of:C23($date); "00")

$path:=getSupportFilesPath+getBranchID+"_"+Table name:C256($tablePtr)+$dateStr+".TXT"
$0:=$path