//%attributes = {}
// setIndex (->field)

C_POINTER:C301($fieldPtr; $1)


Case of 
	: (Count parameters:C259=1)
		$fieldPtr:=$1
	: (Count parameters:C259=2)
		
	Else 
		
End case 



setErrorTrap("setIndex"; "Error in creating index for "+Field name:C257($1))

SET INDEX:C344($fieldPtr->; True:C214; *)


endErrorTrap

