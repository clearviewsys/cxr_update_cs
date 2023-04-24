//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 08/03/16, 15:14:09
// Copyright 2015 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: stringToCSV
// Description
//     converts the passed value (field or var) to a CSV "field"
//     cleans it
//     and wrap it with double quotes and appends a comma if not EOR
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($1; $tTheText)
C_BOOLEAN:C305($2; $bEndOfRecord)

C_TEXT:C284($0)


$tTheText:=$1

$tTheText:=removeEnclosingSpaces($tTheText)

$tTheText:=Replace string:C233($tTheText; ","; " ")  //replace commas with spaces
$tTheText:=Replace string:C233($tTheText; Char:C90(Carriage return:K15:38); " ")  //replace carriage return with space
$tTheText:=Replace string:C233($tTheText; Char:C90(Line feed:K15:40); " ")  //replace line feed with space

$tTheText:=Char:C90(Double quote:K15:41)+$tTheText+Char:C90(Double quote:K15:41)

If (Count parameters:C259>=2)
	$bEndOfRecord:=$2
Else 
	$bEndOfRecord:=False:C215
End if 

If ($bEndOfRecord)
Else 
	$tTheText:=$tTheText+","
End if 

$0:=$tTheText