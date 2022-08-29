//%attributes = {}
C_POINTER:C301($1)  //names
C_POINTER:C301($2)  //values
C_TEXT:C284($token)
ARRAY TEXT:C222($1->; 0)
ARRAY TEXT:C222($2->; 0)

If (Choose:C955(getKeyValue("web.configuration.payments.square.testmode"; "true")="true"; True:C214; False:C215))
	$token:=getKeyValue("web.configuration.payments.square.test.token"; "EAAAELuoASC8neTyvqFwvp1qJKZ00kNgUTullVikbSvBMBCYr9VOG7bkDq0KJpmD")
Else 
	$token:=getKeyValue("web.configuration.payments.square.token"; "EAAAELuoASC8neTyvqFwvp1qJKZ00kNgUTullVikbSvBMBCYr9VOG7bkDq0KJpmD")
End if 

APPEND TO ARRAY:C911($1->; "Square-Version")
APPEND TO ARRAY:C911($2->; "2022-06-16")
APPEND TO ARRAY:C911($1->; "Authorization")
APPEND TO ARRAY:C911($2->; "Bearer "+$token+"")
APPEND TO ARRAY:C911($1->; "Content-Type")
APPEND TO ARRAY:C911($2->; "application/json")
