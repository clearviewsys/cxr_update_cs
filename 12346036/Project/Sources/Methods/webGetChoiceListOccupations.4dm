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




ALL RECORDS:C47([Occupations:2])

ORDER BY:C49([Occupations:2]; [Occupations:2]Occupation:3; >)
SELECTION TO ARRAY:C260([Occupations:2]Occupation:3; $1->; [Occupations:2]Occupation:3; $2->)
//SELECTION TO ARRAY([Occupations]Code;$2->)

INSERT IN ARRAY:C227($1->; 1)
$1->{1}:="-Select an Occupation-"
INSERT IN ARRAY:C227($2->; 1)
$2->{1}:=""