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




C_TEXT:C284($1; $tStoragePath)
C_TEXT:C284($2; $tLocalPath)
C_BOOLEAN:C305($3; $bDelete)
C_TEXT:C284($0)

C_BLOB:C604($xDoc)

$tStoragePath:=$1

If (Count parameters:C259>=2)
	$tLocalPath:=$2
Else 
	$tLocalPath:=""
End if 

If (Count parameters:C259>=3)
	$bDelete:=$3
Else 
	$bDelete:=False:C215
End if 

If ($tLocalPath="")
	$tLocalPath:=Temporary folder:C486+UTIL_LongNameToFileName($tStoragePath)
End if 

If (Test path name:C476($tLocalPath)=Is a folder:K24:2)
	$tLocalPath:=$tLocalPath+UTIL_LongNameToFileName($tStoragePath)
End if 

$xDoc:=DOC_utilRetrieveBlob($tStoragePath; $bDelete)

If (BLOB size:C605($xDoc)>0)
	BLOB TO DOCUMENT:C526($tLocalPath; $xDoc)
	If (OK=1)
	Else 
		$tLocalPath:=""
	End if 
Else 
	$tLocalPath:=""
End if 

$0:=$tLocalPath
