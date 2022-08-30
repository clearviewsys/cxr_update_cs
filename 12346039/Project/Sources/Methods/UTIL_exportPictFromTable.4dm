//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 03/05/20, 08:04:13
// ----------------------------------------------------
// Method: UTIL_exportPictFromTable
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_POINTER:C301($1; $ptrTable)  //table of records to export
C_POINTER:C301($2; $ptrField)  //picture field
C_POINTER:C301($3; $ptrNameField)

C_BLOB:C604($xBlob)
C_TEXT:C284($tFolderPath)
C_LONGINT:C283($i)

$ptrTable:=$1
$ptrField:=$2
$ptrNameField:=$3

ALL RECORDS:C47($ptrTable->)

If (Records in selection:C76($ptrTable->)>0)
	
	$tFolderPath:=Select folder:C670("Select a folder to save images")
	
	For ($i; 1; Records in selection:C76($ptrTable->))
		
		If (Picture size:C356($ptrField->)>0)
			//CONVERT PICTURE($ptrField->;".jpg";0.5)
			PICTURE TO BLOB:C692($ptrField->; $xBlob; ".jpg")
			BLOB TO DOCUMENT:C526($tFolderPath+$ptrNameField->+".jpg"; $xBlob)
		End if 
		
		NEXT RECORD:C51($ptrTable->)
	End for 
	
	
End if 

ALERT:C41("done")