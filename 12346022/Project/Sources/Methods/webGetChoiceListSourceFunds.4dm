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



ALL RECORDS:C47([List_SOF:129])

ORDER BY:C49([List_SOF:129]; [List_SOF:129]Source:3; >)
SELECTION TO ARRAY:C260([List_SOF:129]Source:3; $1->)

If (True:C214)  //---- <>TODO -- MAYBE A KEYVALUE TO CHOOSE B/N CODE OR SOURCE
	SELECTION TO ARRAY:C260([List_SOF:129]Source:3; $2->)
Else 
	SELECTION TO ARRAY:C260([List_SOF:129]Code:2; $2->)
End if 

INSERT IN ARRAY:C227($1->; 1)
$1->{1}:="-Select a Source-"
INSERT IN ARRAY:C227($2->; 1)
$2->{1}:=""