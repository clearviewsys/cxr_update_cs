//%attributes = {"shared":true}
// ----------------------------------------------------
// Project Method: WAPI_hookCreateRecord_Init

//  ` This hook is called before values are added to the new records.
// Here you can initialize the record as needed. ie. Object fields

// Access: Shared

// Parameters: $1=Table Pointer = Pointer; t

//    $2=Array of input name Pointer = Pointer; t

//    $3=Array of input values Pointer = Pointer; t

//    $0=longint = 0=NO error-> save; 1=ERROR -> NO save; t


// Go to the example database to copy the example for this method
// This method was automatically generated by WAPI on Nov 27, 2019.
// WAPI is Copyright 2018 - 2019-- IBB Consulting, LLC 
// ----------------------------------------------------



C_POINTER:C301($1; $ptrTable)
C_POINTER:C301($2; $ptrNameArray)
C_POINTER:C301($3; $ptrValueArray)
C_LONGINT:C283($0; $iError)

$ptrTable:=$1
$ptrNameArray:=$2
$ptrValueArray:=$3

$iError:=0

Case of 
	: ($ptrTable=(->[WebEWires:149]))
		OBJ_newBankInfo(->[WebEWires:149]toBankingInfo:24)
		OBJ_newToParty(->[WebEWires:149]toParty:8)
		OBJ_newFromParty(->[WebEWires:149]fromParty:7)
		OBJ_newThirdParty(->[WebEWires:149]toThirdParty:23)
		OBJ_newAMLInfo(->[WebEWires:149]AML_Info:9)
		OBJ_newPaymentInfo(->[WebEWires:149]paymentInfo:35)
		
	: ($ptrTable=(->[eWires:13]))
		
	: ($ptrTable=(->[Invoices:5]))
		
End case 



$0:=$iError
