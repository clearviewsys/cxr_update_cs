//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 03/05/20, 08:09:40
// ----------------------------------------------------
// Method: UTIL_importPictsForTable
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_POINTER:C301($1; $ptrTable)  //table of records to import
C_POINTER:C301($2; $ptrField)  //picture field
C_POINTER:C301($3; $ptrNameField)

C_BLOB:C604($xBlob)
C_PICTURE:C286($pic)
C_TEXT:C284($tFolderPath; $tID)
C_LONGINT:C283($i)


$ptrTable:=$1
$ptrField:=$2
$ptrNameField:=$3

READ WRITE:C146($ptrTable->)

CONFIRM:C162("are you sure you want to update all images?")
If (OK=1)
	$tFolderPath:=Select folder:C670("Select a folder to import images from")
	
	If (OK=1)
		
		ARRAY TEXT:C222($atDocs; 0)
		DOCUMENT LIST:C474($tFolderPath; $atDocs)
		
		For ($i; 1; Size of array:C274($atDocs))
			
			$tID:=Replace string:C233($atDocs{$i}; ".jpg"; "")
			
			QUERY:C277($ptrTable->; $ptrNameField->=$tID)
			
			If (Records in selection:C76($ptrTable->)>0)
				READ PICTURE FILE:C678($tFolderPath+$atDocs{$i}; $pic)
				$ptrField->:=$pic
				
				SAVE RECORD:C53($ptrTable->)
			End if 
			
			
		End for 
		
	End if 
	
End if 