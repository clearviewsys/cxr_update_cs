//%attributes = {}
// returns collection of distinct years from dates in collection

#DECLARE($dates : Collection; $filterZeros : Boolean)->$years : Collection

If (Count parameters:C259=1)
	$filterZeros:=False:C215
End if 

$years:=$dates.map(Formula:C1597(Year of:C25($1.value))).distinct()

If ($filterZeros)
	$years:=$years.filter(Formula:C1597($1.value>0))
End if 
