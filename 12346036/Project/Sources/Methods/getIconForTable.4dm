//%attributes = {}
// getIconForTable (self; ->[table]) 
C_POINTER:C301($1; $2; $self; $tablePtr)
C_PICTURE:C286($0)

Case of 
	: (Count parameters:C259=1)
		$self:=$1
		$tablePtr:=Current form table:C627
		
	: (Count parameters:C259=2)
		$self:=$1
		$tablePtr:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

loadPictureResource("_"+Table name:C256($tablePtr); $Self)
//GET PICTURE FROM LIBRARY("_"+Table name($tablePtr); $Self->)