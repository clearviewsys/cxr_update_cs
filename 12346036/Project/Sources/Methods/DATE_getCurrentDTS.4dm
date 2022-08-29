//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 03/25/20, 07:58:53
// ----------------------------------------------------
// Method: DATE_getCurrentDTS
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($0; $tDTS)

C_DATE:C307($dDate)
C_TIME:C306($hTime)


$dDate:=Current date:C33
$hTime:=Current time:C178

$tDTS:=String:C10(Year of:C25($dDate))+String:C10(Month of:C24($dDate))+String:C10(Day of:C23($dDate))

$tDTS:=$tDTS+Replace string:C233(String:C10($hTime); ":"; "")

$0:=$tDTS