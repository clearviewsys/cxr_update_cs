//%attributes = {}


//
// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 07/23/22, 07:48:50
// ----------------------------------------------------
// Method: DOC_storeDocumentPath
// Description
// 
//
// Parameters
// ----------------------------------------------------



//document to store
C_TEXT:C284($1; $tPath)  // local document path to store
C_TEXT:C284($2; $tRootPath)

C_TEXT:C284($0)  // path at server 


C_TEXT:C284($tFilename)
C_BLOB:C604($xDoc)

$tPath:=$1  //LOCAL path to document to store

If (Count parameters:C259>=2)
	$tRootPath:=$2
Else 
	$tRootPath:=DOC_getStoragePath
End if 


If (Test path name:C476($tPath)=Is a document:K24:1)
	$tFilename:=UTIL_LongNameToFileName($tPath)
	DOCUMENT TO BLOB:C525($tPath; $xDoc)
	If (OK=1)
		$tPath:=DOC_utilStoreBlob($xDoc; $tFilename; $tRootPath)  //path at the server
	Else 
		$tPath:=""
	End if 
Else 
	$tPath:=""
End if 


$0:=$tPath
