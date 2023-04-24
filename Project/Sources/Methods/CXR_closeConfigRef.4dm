//%attributes = {"executedOnServer":true}

// ----------------------------------------------------
// User name (OS): barclay
// Date and time: 09/17/18, 12:39:28
// ----------------------------------------------------
// Method: CXR_closeConfigRef
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($1; $tRef)
C_TEXT:C284($tPath)
$tRef:=$1

$tPath:=Get 4D folder:C485(Database folder:K5:14)+"CXR_settings.xml"

If (Test path name:C476($tPath)=Is a document:K24:1)  //for now just assume an update
	DOM EXPORT TO FILE:C862($tRef; $tPath)
Else 
	DOM EXPORT TO FILE:C862($tRef; $tPath)  // doesn't make sense TB
End if 

DOM CLOSE XML:C722($tRef)
