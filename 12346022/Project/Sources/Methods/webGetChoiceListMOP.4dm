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


READ ONLY:C145([PaymentTypes:116])

ALL RECORDS:C47([PaymentTypes:116])

ORDER BY:C49([PaymentTypes:116]; [PaymentTypes:116]PaymentType:3; >)
SELECTION TO ARRAY:C260([PaymentTypes:116]PaymentType:3; $1->; [PaymentTypes:116]Code:2; $2->)

INSERT IN ARRAY:C227($1->; 1)
$1->{1}:="-Select-"
INSERT IN ARRAY:C227($2->; 1)
$2->{1}:=""

//SELECTION TO ARRAY([PaymentTypes]Code;$2->)  `<--- need to update web for MOPCode instead of MOP