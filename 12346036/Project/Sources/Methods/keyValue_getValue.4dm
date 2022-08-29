//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay
// Date and time: 06/01/18, 12:06:54
// ----------------------------------------------------
// Method: keyValue_getValue
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $tKey)
C_TEXT:C284($2; $tDefault)

C_TEXT:C284($0; $tValue)


$tKey:=$1

If (Count parameters:C259>=2)
	$tDefault:=$2
Else 
	$tDefault:=""
End if 

$tValue:=""

READ ONLY:C145([KeyValues:115])

QUERY:C277([KeyValues:115]; [KeyValues:115]Key:2=$tKey; *)
QUERY:C277([KeyValues:115];  & ; [KeyValues:115]expireDate:6<=Current date:C33)

If (Records in selection:C76([KeyValues:115])=1)
	$tValue:=[KeyValues:115]Value:3
Else 
	$tValue:=""
End if 

If ($tValue="")
	$tValue:=$tDefault
End if 

$0:=$tValue