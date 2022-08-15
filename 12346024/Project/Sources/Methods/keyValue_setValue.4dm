//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay
// Date and time: 06/01/18, 12:09:17
// ----------------------------------------------------
// Method: keyValue_setValue
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($1; $tKey)
C_TEXT:C284($2; $tValue)
C_DATE:C307($3; $dExpires)

$tKey:=$1
$tValue:=$2

If (Count parameters:C259>=3)
	$dExpires:=$3
Else 
	$dExpires:=!00-00-00!
End if 

READ WRITE:C146([KeyValues:115])
QUERY:C277([KeyValues:115]; [KeyValues:115]Key:2=$tKey)

QUERY SELECTION:C341([KeyValues:115]; [KeyValues:115]expireDate:6>=Current date:C33; *)
QUERY SELECTION:C341([KeyValues:115];  | ; [KeyValues:115]expireDate:6=!00-00-00!)

Case of 
	: (Records in selection:C76([KeyValues:115])=1)
		[KeyValues:115]Value:3:=$tValue
		[KeyValues:115]expireDate:6:=$dExpires
		SAVE RECORD:C53([KeyValues:115])
		
	: (Records in selection:C76([KeyValues:115])=0)
		CREATE RECORD:C68([KeyValues:115])
		[KeyValues:115]Key:2:=$tKey
		[KeyValues:115]Value:3:=$tValue
		[KeyValues:115]expireDate:6:=$dExpires
		SAVE RECORD:C53([KeyValues:115])
	Else 
		//TRACE
End case 

UNLOAD RECORD:C212([KeyValues:115])
REDUCE SELECTION:C351([KeyValues:115]; 0)
READ ONLY:C145([KeyValues:115])