//%attributes = {}
// getAbbrDateString (date )-> string
// this string returns the month and year only
// ex; : "1/1/03" -> Jan 03

C_DATE:C307($1)
C_TEXT:C284($0)

$0:=getAbbrMonthName(Month of:C24($1))+"."+Substring:C12(String:C10(Year of:C25($1)); 3)

