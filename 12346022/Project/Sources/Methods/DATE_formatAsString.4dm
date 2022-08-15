//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 08/05/16, 12:58:10
// Copyright 2015 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: DATE_formatAsString
// Description
//      converts a date into a string format
//
// Parameters
// ----------------------------------------------------



C_DATE:C307($1; $theDate)
C_TEXT:C284($2; $theFormat)

C_TEXT:C284($0; $theResult)


$theDate:=$1

If (Count parameters:C259>=2)
	$theFormat:=$2
Else 
	$theFormat:="YYYY-MM-DD"
End if 



Case of 
	: ($theFormat="YYYY-MM-DD")
		$theResult:=Substring:C12(String:C10($theDate; ISO date GMT:K1:10); 1; 10)
		
	: ($theFormat="YYYYMMDD")
		$theResult:=Substring:C12(String:C10($theDate; ISO date GMT:K1:10); 1; 10)
		$theResult:=Replace string:C233($theResult; "-"; "")
		
	Else 
		
End case 


$0:=$theResult