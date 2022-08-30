//%attributes = {}
// showDateRangeTable (->[TABLE]; ->dateField)
//

C_POINTER:C301($tablePtr; $dateFieldPtr; $1; $2)
$tablePtr:=$1
$dateFieldPtr:=$2

If ((Not:C34(Is nil pointer:C315($tablePtr))) & (Not:C34(Is nil pointer:C315($dateFieldPtr))))
	
	setErrorTrap(Current method name:C684)
	requestDateRangeTable($tablePtr; $dateFieldPtr)
	cbApplyDateRange:=1
	endErrorTrap
End if 