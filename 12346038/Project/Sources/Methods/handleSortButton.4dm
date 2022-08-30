//%attributes = {}
// handleSortButton(->field;->field2;true)
// the thir parametre is sometimes used when  you want to keep the order of the first fireld while switching the order of the second
// you should look at the code to understand
// the third parameter is used to sort on amount and a field like Paid
// ex: handleSortButton(->[cheques]paid;->[cheques]amount;false)

C_BOOLEAN:C305(sortOrder; $sortSwitch; $3)
C_POINTER:C301($1; $2)
Case of 
	: (Count parameters:C259=1)
		If (sortOrder)
			ORDER BY:C49(Current form table:C627->; $1->; >)
		Else 
			ORDER BY:C49(Current form table:C627->; $1->; <)
		End if 
	: (Count parameters:C259=2)
		If (sortOrder)
			ORDER BY:C49(Current form table:C627->; $1->; >; $2->; >)
		Else 
			ORDER BY:C49(Current form table:C627->; $1->; >; $2->; <)
		End if 
	: (Count parameters:C259=3)
		$sortSwitch:=$3
		If ($sortSwitch=True:C214)
			If (sortOrder)
				ORDER BY:C49(Current form table:C627->; $1->; >; $2->; >)
			Else 
				ORDER BY:C49(Current form table:C627->; $1->; <; $2->; >)
			End if 
		Else   // else
			If (sortOrder)
				ORDER BY:C49(Current form table:C627->; $1->; >; $2->; >)
			Else 
				ORDER BY:C49(Current form table:C627->; $1->; <; $2->; <)
			End if 
		End if 
End case 
sortOrder:=Not:C34(sortOrder)

If (Form event code:C388=On Double Clicked:K2:5)
	BEEP:C151
End if 

