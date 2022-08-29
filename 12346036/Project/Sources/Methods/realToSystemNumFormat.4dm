//%attributes = {}
// ------------------------------------------------------------------------------
// Method: realToSystemNumFormat: 
//        Returns a real value from a string value
//
// Parameters: 
//    $1: Real value (in text format)
// Return
//    Value in Real Format
// 
// ------------------------------------------------------------------------------
// Jaime Alvarez, March 18/2015
// ------------------------------------------------------------------------------

C_REAL:C285($0)
C_TEXT:C284($1)
C_TEXT:C284($decimalSep; $tmpValue)

GET SYSTEM FORMAT:C994(Decimal separator:K60:1; $decimalSep)

// Use the system decimal separator
$tmpValue:=Replace string:C233($1; ","; $decimalSep)
$0:=Num:C11($tmpValue)

