//%attributes = {}
//displaySanctionListResults($sanctionList)
//
// Parameters:
// $sanctionList      (C_OBJECT)
// Returns: (C_TEXT)
//     The reason to hold the Customer
// Author: Wai-Kin
//sl_displaySanctionListResult($selection : cs.SanctionCheckLogSelection; $showInterface : Boolean; \
$iconPtr : Pointer; $textPtr : Pointer; \
$logIdPtr : Pointer)->$status : Real
C_OBJECT:C1216($form)

var $selection; $1 : 4D:C1709.EntitySelection
var $showInterface; $2 : Boolean
var $iconPtr; $3 : Pointer
var $textPtr; $4 : Pointer
var $logIdPtr; $5 : Pointer
var $status; $0 : Real
$showInterface:=True:C214
Case of 
	: (Count parameters:C259=1)
		$selection:=$1
	: (Count parameters:C259=2)
		$selection:=$1
		$showInterface:=$2
	: (Count parameters:C259=3)
		$selection:=$1
		$showInterface:=$2
		$iconPtr:=$3
	: (Count parameters:C259=4)
		$selection:=$1
		$showInterface:=$2
		$iconPtr:=$3
		$textPtr:=$4
	: (Count parameters:C259=5)
		$selection:=$1
		$showInterface:=$2
		$iconPtr:=$3
		$textPtr:=$4
		$logIdPtr:=$5
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$form:=slold_setupDisplayListBox($selection; $showInterface)

$status:=$form.resultStatus
If ($form.resultStatus#0)
	If ($showInterface)
		C_LONGINT:C283($winRef)
		$winRef:=Open form window:C675("SanctionList1")
		DIALOG:C40("SanctionList1"; $form)
		CLOSE WINDOW:C154($winRef)
	End if 
End if 

If ($iconPtr#Null:C1517)
	sl_setSanctionListCheckIcon($form.resultStatus; $iconPtr)
End if 

If ($textPtr#Null:C1517)
	$textPtr->:=$form.result
End if 

If ($logIdPtr#Null:C1517)
	QUERY:C277([SanctionCheckLog:111]; [SanctionCheckLog:111]internalTableID:12=Table:C252($logIdPtr); *)
	QUERY:C277([SanctionCheckLog:111];  & ; [SanctionCheckLog:111]InternalRecordID:2=$logIdPtr->)
End if 
$0:=$status