//%attributes = {}

C_TEXT:C284($methodName)



setErrorTrap("showDateRange")
$methodName:=Substring:C12("showDateRange"+Table name:C256(Current form table:C627); 1; 31)
executeMethodName($methodName)
endErrorTrap
SET TIMER:C645(-1)
// showDateRangeTable