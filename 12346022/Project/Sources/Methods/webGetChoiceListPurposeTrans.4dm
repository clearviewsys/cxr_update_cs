//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 04/11/18, 22:21:13
// ----------------------------------------------------
// Method: webGetChoiceListCountries
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_POINTER:C301($1)  //option - pointer to array to fill
C_POINTER:C301($2)  //option value
C_POINTER:C301($3)  //option label




ALL RECORDS:C47([List_POT:128])

ORDER BY:C49([List_POT:128]; [List_POT:128]Purpose:3; >)
SELECTION TO ARRAY:C260([List_POT:128]Purpose:3; $1->)

If (True:C214)  //--- <>TODO -- MAYBE USE KEYVALUE
	SELECTION TO ARRAY:C260([List_POT:128]Purpose:3; $2->)
Else 
	SELECTION TO ARRAY:C260([List_POT:128]Code:2; $2->)  //<--- need to update web for MOPCode instead of MOP
End if 

INSERT IN ARRAY:C227($1->; 1)
$1->{1}:="-Select a Purpose-"
INSERT IN ARRAY:C227($2->; 1)
$2->{1}:=""