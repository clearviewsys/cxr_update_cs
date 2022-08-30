//%attributes = {}
// handlePickCustomerOccupation (form event; objectPtr; isForced)


C_LONGINT:C283($formEvent; $1)
C_POINTER:C301($objectPtr; $2)
C_BOOLEAN:C305($isForced; $3)

$formEvent:=$1
$objectPtr:=$2
$isForced:=$3

If (Form event code:C388=$formEvent)
	pickOccupation($objectPtr; $isForced)
	If (OK=1)
		//RELATE ONE([Customers]OccupationCode)
		[Customers:3]OccupationCode:121:=[Occupations:2]Code:2
		[Customers:3]Occupation:21:=[Occupations:2]Occupation:3
	End if 
End if 