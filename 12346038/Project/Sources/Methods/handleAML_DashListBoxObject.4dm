//%attributes = {}
C_POINTER:C301($tablePtr; $1; $self; $2)

Case of 
	: (Count parameters:C259=1)
		$self:=$1
		$tablePtr:=getAMLDashboardTabTablePtr
	: (Count parameters:C259=2)
		$self:=$1
		$tablePtr:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (Form event code:C388=On Double Clicked:K2:5)
	handledoubleclickevent($tablePtr)
Else 
	handleListboxColumnsSettings($self; $tablePtr; "AML_Dashboard"; "mainListbox_"+Table name:C256($tablePtr))
End if 