//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 09/06/19, 09:44:29
// ----------------------------------------------------
// Method: webGetChoiceListGender
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_POINTER:C301($1)  //option
C_POINTER:C301($2)  //value
C_POINTER:C301($3)  //label


APPEND TO ARRAY:C911($1->; "Buy")
APPEND TO ARRAY:C911($1->; "Sell")

If (Count parameters:C259>=2)
	APPEND TO ARRAY:C911($2->; "False")
	APPEND TO ARRAY:C911($2->; "True")
End if 

If (Count parameters:C259>=3)
	APPEND TO ARRAY:C911($3->; "Buy")
	APPEND TO ARRAY:C911($3->; "Sell")
End if 