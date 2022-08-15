//%attributes = {}
// isAuthorizedForListing(->table)-> boolean
// returns true if the module is allowed displayList

//
//C_POINTER($1;$tablePtr;$fieldPtr)
//C_BOOLEAN($0)
//
//selectMAC 
//$fieldPtr:=getModuleFieldPtr ($1)
//If (Table($1)=Table(->[MACs]))  ` authorized the MACs to be opened at all times
//$0:=True
//Else 
//If ($fieldPtr->=0)  `if the number is zero , it is not authorized for viewling
//$0:=False
//Else 
//$0:=True
//
//End if 
//End if 


C_POINTER:C301($tablePtr; $1)
$tablePtr:=$1
$0:=isModuleAuthorized($tablePtr)

