//%attributes = {}
// ----------------------------------------------------

// User name (OS): Jonathan Le

// Date and time: 04/02/04, 09:26:35

// ----------------------------------------------------

// Method: BKP_XML_GetSettings

// Description

// 

//

// Parameters

// $1 -a reference to the parent element in the DOM

// $2 - the relative XPath

// ----------------------------------------------------

C_TEXT:C284($1; $2)
C_LONGINT:C283($0)
C_TEXT:C284($tParentElem)
C_TEXT:C284($tXPath)
$tXPath:=$2

If (Count parameters:C259>0)
	$tParentElem:=DOM Find XML element:C864($1; $tXPath)
Else 
	// we don't have a paremeter, so we must use the interprocess defined in BKP_XML_Initialize

	$tParentElem:=DOM Find XML element:C864(BKP_XML_GetParentElem; <>tDefaultXPath+"/"+$tXPath)
End if 

$0:=BKP_XML_PopulateVariables($tParentElem; $tXPath)