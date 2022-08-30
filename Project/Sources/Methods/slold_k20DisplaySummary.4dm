//%attributes = {}
var $entity : cs:C1710.SanctionCheckLogEntity

Case of 
	: (Count parameters:C259=1)
		$entity:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($entity.CheckResult#0)
	C_LONGINT:C283($winRef)
	$winRef:=Open form window:C675("SanctionCheckKYC2020")
	DIALOG:C40("SanctionCheckKYC2020"; $entity.toObject())
	CLOSE WINDOW:C154($winRef)
End if 