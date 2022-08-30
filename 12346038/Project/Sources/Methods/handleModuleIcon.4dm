//%attributes = {}
C_POINTER:C301($tablePtr; $objectPtr; $1; $2)
Case of 
	: (Count parameters:C259=0)
		$tablePtr:=Current form table:C627
		$objectPtr:=Self:C308
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$objectPtr:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
loadPictureResource("_"+Table name:C256($tablePtr); $objectPtr)
//GET PICTURE FROM LIBRARY("_"+Table name($tablePtr); $objectPtr->)
//If (Table($tablePtr)#Table(->[DB_Tables]))
//READ ONLY([DB_Tables])
//QUERY([DB_Tables];[DB_Tables]TableNo=Table($tablePtr))
//If (Records in selection([DB_Tables])=1)
//$objectPtr->:=[DB_Tables]smallIcon
//End if 
//End if 