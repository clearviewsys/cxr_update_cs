//%attributes = {}
// getMainListBoxSetName (-> form table) : string

C_POINTER:C301($1; $tablePtr)
C_TEXT:C284($result; $0)
$tablePtr:=$1


//If (Records in set(iLB_Get_SetName (->mainListbox))=0)
$0:="$"+Table name:C256($tablePtr)+"_LBSet"
//Else 
//$0:=iLB_Get_SetName (->mainListbox)
//End if 