//%attributes = {}
// listbox_handleDisplayRecordOnDC( listboxPtr ; ->[Table];->arrPrimaryKey; accessGranted)
// ex: listbox_handleDisplayRecordOnDC (self;->[Items];->inv_arrItemIDs)
// the last parameter is for denial in certain cases 

C_POINTER:C301($listBoxPtr; $1; $tablePtr; $2; $arrPtr; $3)
C_BOOLEAN:C305($accessGranted; $4)

Case of 
	: (Count parameters:C259=3)
		$listBoxPtr:=$1
		$tablePtr:=$2
		$arrPtr:=$3
		$accessGranted:=True:C214
		
	: (Count parameters:C259=4)
		$listBoxPtr:=$1
		$tablePtr:=$2
		$arrPtr:=$3
		$accessGranted:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


If (Form event code:C388=On Double Clicked:K2:5)
	C_LONGINT:C283($row)
	$row:=listbox_getSelectedRowNumber($listBoxPtr)
	displayRecordID(Table:C252($tablePtr); $arrPtr->{$row}; $accessGranted)
	
End if 

If (Form event code:C388=On Header Click:K2:40)
	LISTBOX SELECT ROW:C912($listBoxPtr->; 0; lk remove from selection:K53:3)
End if 

If (Form event code:C388=On Load:K2:1)
	LISTBOX SORT COLUMNS:C916($listBoxPtr->; 1; >)
End if 