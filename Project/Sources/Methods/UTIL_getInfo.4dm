//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay
// Date and time: 10/02/18, 18:19:55
// ----------------------------------------------------
// Method: UTIL_getInfo
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $tType)
C_TEXT:C284($0; $tInfo)


$tType:=$1
$tInfo:=""

Case of 
	: ($tType="")
		
	: ($tType="")
		
	Else 
		$tInfo:="UNKNOWN Request"
End case 


$0:=$tInfo