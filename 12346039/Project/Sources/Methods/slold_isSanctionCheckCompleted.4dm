//%attributes = {}
// sl_isSanctionCheckCompleted($signalListName : Text; $form : Object) -> $complete : Boolean
// Author Wai-Kin
var $sanctionCheckSignals; $1 : Text
var $form; $2 : Object
var $complete; $0 : Boolean


$sanctionCheckSignals:="sanctionCheckSignals"
$form:=Form:C1466

Case of 
	: (Count parameters:C259=0)
	: (Count parameters:C259=1)
		$sanctionCheckSignals:=$1
	: (Count parameters:C259=2)
		$sanctionCheckSignals:=$1
		$form:=$2
End case 

If (OB Is defined:C1231($form; $sanctionCheckSignals))
	$complete:=$form[$sanctionCheckSignals].length=0
	
Else 
	$complete:=True:C214
End if 

$0:=$complete