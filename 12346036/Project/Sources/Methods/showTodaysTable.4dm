//%attributes = {}
//showTodaysTable (->[TABLE];->dateField)


C_POINTER:C301($tablePtr; $dateFieldPtr; $1; $2)
$tablePtr:=$1
$dateFieldPtr:=$2

If ((Not:C34(Is nil pointer:C315($tablePtr))) & (Not:C34(Is nil pointer:C315($dateFieldPtr))))
	setErrorTrap("showTodays"+Table name:C256($tablePtr))
	handleTodayButton($tablePtr; $dateFieldPtr)
	endErrorTrap
End if 