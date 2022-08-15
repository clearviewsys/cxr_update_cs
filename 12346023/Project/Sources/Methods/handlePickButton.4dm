//%attributes = {}
// handlePickButton ( ->table; ->primaryKey;->listBox;->vSearchText)
// handlePickButton (->[customers];->customerID;->lb_picker;->vSearchText)

C_POINTER:C301($tablePtr; $fieldPtr; $listBoxPtr; $formSearchPtr; $1; $2; $3; $4)
C_LONGINT:C283($n)
$tablePtr:=$1
$fieldPtr:=$2
$listBoxPtr:=$3
$formSearchPtr:=$4


// Modified by: Tiran Behrouz (5/9/13)
$n:=Records in selection:C76($tablePtr->)
C_LONGINT:C283($col; $row)
LISTBOX GET CELL POSITION:C971($listBoxPtr->; $col; $row)


Case of 
		//:($n=1) // one record selected 
		
	: ($n>=1)
		If ($row>0)
			GOTO SELECTED RECORD:C245($tablePtr->; $row)
		Else 
			GOTO SELECTED RECORD:C245($tablePtr->; 1)
		End if 
		
		READ ONLY:C145($tablePtr->)  // newly added in version 3.601
		LOAD RECORD:C52($tablePtr->)  // load the reocrd
		$formSearchPtr->:=$fieldPtr->  // point to the ID
		ACCEPT:C269
		
		//: ($n>1)
		//$formSearchPtr->:=listbox_getSelectedRecordField ($listBoxPtr;$tablePtr;$fieldPtr)
		//ACCEPT
	Else 
		REJECT:C38
End case 

