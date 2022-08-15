//%attributes = {}
// ----------------------------------------------------

// User name (OS): Jonathan Le

// Date and time: 04/02/04, 09:28:11

// ----------------------------------------------------

// Method: BKP_XML_WriteData

// Description

// 

//

// Parameters

// ----------------------------------------------------

C_TIME:C306($0; $1; $tiDocRef)
C_TEXT:C284($2; $tElem; $3; $tData)

$tiDocRef:=$1
$tElem:=$2
$tData:=$3

SAX OPEN XML ELEMENT:C853($tiDocRef; $tElem)
SAX ADD XML ELEMENT VALUE:C855($tiDocRef; $tData)
SAX CLOSE XML ELEMENT:C854($tiDocRef)

$0:=$tiDocRef
