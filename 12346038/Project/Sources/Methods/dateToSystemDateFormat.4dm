//%attributes = {}
// ------------------------------------------------------------------------------
// Method: dateToSystemDateFormat: 
//         Return a date in the System Date Format
// Parameters:
//   $1: day
//   $2: Month
//   $3: Year
// Returns: Date
// ------------------------------------------------------------------------------

C_DATE:C307($0)

C_LONGINT:C283($1; $2; $3)
C_TEXT:C284($strDay; $strMonth; $strYear; $strDate)

$strDay:=String:C10($1)
$strMonth:=String:C10($2)
$strYear:=String:C10($3)

$strDate:=Lowercase:C14(getSystemDateFormat)

$strDate:=Replace string:C233($strDate; "d"; $strDay)
$strDate:=Replace string:C233($strDate; "m"; $strMonth)
$strDate:=Replace string:C233($strDate; "y"; $strYear)

$0:=Date:C102($strDate)

