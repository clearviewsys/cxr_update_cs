//%attributes = {"executedOnServer":true}

// ----------------------------------------------------
// User name (OS): barclay
// Date and time: 09/17/18, 12:24:44
// ----------------------------------------------------
// Method: CXR_openConfigRef
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0; $sRootRef)

C_TEXT:C284($tPath)

$tPath:=Get 4D folder:C485(Database folder:K5:14)+"CXR_settings.xml"

If (Test path name:C476($tPath)=Is a document:K24:1)  //read it
	$sRootRef:=DOM Parse XML source:C719($tPath)
Else 
	$sRootRef:=""
End if 

$0:=$sRootRef