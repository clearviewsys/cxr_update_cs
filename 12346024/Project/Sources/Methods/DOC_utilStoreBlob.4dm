//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 03/18/20, 15:35:17
// ----------------------------------------------------
// Method: iH_handleFile
// Description
// 
//
// Parameters
// ----------------------------------------------------


// execute on server property 


C_BLOB:C604($1; $xDoc)  //document to store
C_TEXT:C284($2; $tFileName)
C_TEXT:C284($3; $tRootPath)

C_TEXT:C284($0; $tPath)


C_TEXT:C284($tDTS; $tExt)

$xDoc:=$1

$tDTS:="DTS"+Replace string:C233(Replace string:C233(String:C10(Current date:C33)+String:C10(Current time:C178); "/"; ""); ":"; "")

If (Count parameters:C259>=2)
	$tFileName:=$2
Else 
	$tFileName:=$tDTS
End if 

If (Count parameters:C259>=3)
	$tRootPath:=$3
Else 
	$tRootPath:=Get 4D folder:C485(Database folder:K5:14; *)+"HolaFileStore"+Folder separator:K24:12
End if 


$tPath:=$tRootPath

If (Test path name:C476($tPath)=Is a folder:K24:2)
Else 
	CREATE FOLDER:C475($tPath; *)
End if 

If (Test path name:C476($tPath+$tFileName)=Is a document:K24:1)  //duplicate
	$tExt:=UTIL_filenameToExtension($tPath+$tFileName)
	$tFileName:=Replace string:C233($tFileName; $tExt; "")+"_"+$tDTS+$tExt
End if 

BLOB TO DOCUMENT:C526($tPath+$tFileName; $xDoc)

If (OK=1)
	$0:=$tPath+$tFileName
Else 
	$0:=""
End if 