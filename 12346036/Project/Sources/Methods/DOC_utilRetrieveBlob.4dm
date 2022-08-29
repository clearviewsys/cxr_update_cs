//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 03/18/20, 16:02:46
// ----------------------------------------------------
// Method: iH_documentGet
// Description
// 
//
// Parameters
// ----------------------------------------------------




C_TEXT:C284($1; $tPath)
C_BOOLEAN:C305($2; $bDelete)

C_BLOB:C604($0; $xDoc)

$tPath:=$1

If (Count parameters:C259>=2)
	$bDelete:=$2
Else 
	$bDelete:=False:C215
End if 

If (Test path name:C476($tPath)=Is a document:K24:1)  //found it
	DOCUMENT TO BLOB:C525($tPath; $xDoc)
	
	If (OK=1) & ($bDelete)
		DELETE DOCUMENT:C159($tPath)  //clean up
	End if 
	
End if 

$0:=$xDoc
