//%attributes = {"shared":true}
// displayRecord_(-> table; boolean)
// $2 parameter is optional, pass True if the table will use Object Form.

C_LONGINT:C283($recordNumber; $winRef)
C_POINTER:C301($1; $tablePtr)
C_OBJECT:C1216($entity)
C_BOOLEAN:C305($useObjectForm; $2)
$useObjectForm:=False:C215

$recordNumber:=<>RecordNo
$tablePtr:=$1

If (Count parameters:C259>=2)
	$useObjectForm:=$2
End if 

If (isUserAuthorizedToView($1))
	$winRef:=Open form window:C675($tablePtr->; "View"; Plain window:K34:13; Horizontally centered:K39:1; Vertically centered:K39:4; *)
	//read only(*) Changed by TB Oct 2018
	READ ONLY:C145($tablePtr->)
	DEFAULT TABLE:C46($tablePtr->)  //ibb 3/30/20
	USE NAMED SELECTION:C332(getTableNamedSelection($tablePtr))
	CLEAR NAMED SELECTION:C333(getTableNamedSelection($tablePtr))
	
	GOTO SELECTED RECORD:C245($tablePtr->; $recordNumber)
	If ($useObjectForm)
		$entity:=Create entity selection:C1512($tablePtr->)
		DIALOG:C40($tablePtr->; "View"; $entity[$recordNumber-1])  // pass the object entity to the form
	Else 
		DIALOG:C40($tablePtr->; "View")
	End if 
	
	CLOSE WINDOW:C154
	READ WRITE:C146(*)
End if 

