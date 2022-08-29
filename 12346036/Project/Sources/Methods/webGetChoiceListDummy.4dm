//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 02/20/19, 15:02:01
// ----------------------------------------------------
// Method: webGetChoiceListDummy
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_POINTER:C301($1)  //option
C_POINTER:C301($2)  //value
C_POINTER:C301($3)  //label

C_TEXT:C284($tValue)

$tValue:="Unavailable"

APPEND TO ARRAY:C911($1->; $tValue)
If (Count parameters:C259>=2)
	APPEND TO ARRAY:C911($2->; $tValue)
End if 

If (Count parameters:C259>=3)
	APPEND TO ARRAY:C911($3->; $tValue)
End if 