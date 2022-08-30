//%attributes = {}
// ----------------------------------------------------

// User name (OS): Jonathan Le

// Date and time: 04/02/04, 09:26:40

// ----------------------------------------------------

// Method: BKP_XML_GetSimpleName

// Description

// 

//

// Parameters

// ----------------------------------------------------

C_TEXT:C284($1; $0)
C_TEXT:C284($tTemp)

$tTemp:=$1

While (Position:C15("/"; $tTemp)#0)
	$tTemp:=Substring:C12($tTemp; Position:C15("/"; $tTemp)+1)
End while 

$0:=$tTemp