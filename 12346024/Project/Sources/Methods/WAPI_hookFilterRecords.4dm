//%attributes = {"shared":true}
// ----------------------------------------------------
// Project Method: WAPI_hookFilterRecords

//  ` This hook is called before records are sent to the browser.
// Here you can filter the current selection for a given table/view

// Access: Shared

// Parameters: $1=Table Pointer = Pointer; t


// Go to the example database to copy the example for this method
// This method was automatically generated by WAPI on Apr 14, 2018.
// WAPI is Copyright 2018 - 2018-- IBB Consulting, LLC 
// ----------------------------------------------------

C_POINTER:C301($1; $ptrTable)
C_TEXT:C284($2; $tEvent)
C_POINTER:C301($3; $ptrNameArray)
C_POINTER:C301($4; $ptrValueArray)

C_POINTER:C301($ptrNull)
//TRACE

$ptrTable:=$1
$tEvent:=$2

If (Count parameters:C259>=3)
	$ptrNameArray:=$3
Else 
	$ptrNameArray:=$ptrNull
End if 

If (Count parameters:C259>=4)
	$ptrValueArray:=$4
Else 
	$ptrValueArray:=$ptrNull
End if 


Case of 
	: ($tEvent="updateRecord")
		
	: ($tEvent="createRecord")
		
	Else 
		filterSelection_($ptrTable; $tEvent; $ptrNameArray; $ptrValueArray)
End case 