//%attributes = {}
// findStringInTable (->[table];searchString)

// select record in the table that match the searchString


C_POINTER:C301($1)
C_TEXT:C284($2; $setName; $searchString)
$searchString:=$2
$setName:="search"+Table name:C256($1->)
CREATE SET:C116($1->; $setName)

C_LONGINT:C283($i; $fieldType)

For ($i; 1; Get last field number:C255($1))
	If (Is field number valid:C1000($1; $i))  // Jan 16, 2012 18:25:05 -- I.Barclay Berry 
		GET FIELD PROPERTIES:C258(Table:C252($1); $i; $fieldType)
		Case of 
			: ($fieldType=Is alpha field:K8:1)
				If (Position:C15($searchString; Field:C253(Table:C252($1); $i)->)>0)  // if string is found in some positive position
					
					
				End if 
			: ($fieldType=Is text:K8:3)
		End case 
	End if 
End for 


