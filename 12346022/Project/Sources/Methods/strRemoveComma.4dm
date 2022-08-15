//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 08/03/16, 14:45:40
// Copyright 2015 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: strRemoveComma
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($1; $tTheText)

C_TEXT:C284($0)


$tTheText:=$1


If (Length:C16($tTheText)>0)
	
	$tTheText:=Replace string:C233($tTheText; ","; " ")  //replace comma's with spaces
	
End if 


$0:=$tTheText