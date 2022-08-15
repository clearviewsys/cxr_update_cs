//%attributes = {}
// getModuleIcon (->table;self)

C_POINTER:C301($tablePtr; $self; $1; $2)

If (Count parameters:C259=2)
	$tablePtr:=$1
	$self:=$2
	loadPictureResource("_"+Table name:C256($tablePtr); $self)
	//GET PICTURE FROM LIBRARY("_"+Table name($tablePtr); $self->)
	
End if 