//%attributes = {}
// ----------------------------------------------------

// User name (OS): Jonathan Le

// Date and time: 04/02/04, 09:25:53

// ----------------------------------------------------

// Method: BKP_XML_EndDocument

// Description

// 

//

// Parameters

// ----------------------------------------------------

C_TIME:C306($1; $0; $tiDocRef)

$tiDocRef:=$1

SAX CLOSE XML ELEMENT:C854($tiDocRef)
SAX CLOSE XML ELEMENT:C854($tiDocRef)

$0:=$tiDocRef