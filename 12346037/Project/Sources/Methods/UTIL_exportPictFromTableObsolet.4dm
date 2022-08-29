//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 03/05/20, 08:04:13
// ----------------------------------------------------
// Method: UTIL_exportPictFromTableObsolete
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
C_PICTURE:C286($picture)

$ptrTable:=$1
$ptrField:=$2
$ptrNameField:=$3

ALL RECORDS:C47($ptrTable->)

If (Records in selection:C76($ptrTable->)>0)
	
	$tFolderPath:=Select folder:C670("Select a folder to save images")
	
	For ($i; 1; Records in selection:C76($ptrTable->))
		
		If (Picture size:C356($ptrField->)>0)
			$picture:=$ptrField->
			
			If (True:C214)
				//If (_o_AP Is Picture Deprecated($picture)=1)  // if format is obsolete ` <----- UNCOMMENT FOR V13
				CONVERT PICTURE:C1002($picture; ".JPG"; 0.5)  // conversion to png
				PICTURE TO BLOB:C692($picture; $xBlob; ".jpg")
				BLOB TO DOCUMENT:C526($tFolderPath+$ptrNameField->+".jpg"; $xBlob)
				//end if   ` <----- UNCOMMENT FOR V13
			Else 
				//<>TODO
				//$picture:=$ptrField->
				//  //If (UTIL_isMethodExists ("_o_AP Is Picture Deprecated"))
				//  //If (_o_AP Is Picture Deprecated($picture)=1)  // if format is obsolete
				//  //EXECUTE METHOD("_o_AP Is Picture Deprecated";$iResult;$picture)
				//  //If ($iResult=1)
				//CONVERT PICTURE($picture;".JPG";0.5)  // conversion to png
				//  //TRANSFORM PICTURE($Pict_G;Transparency;0x00FFFFFF)  /
				//  //CONVERT PICTURE($ptrField->;".jpg";0.5)
				//PICTURE TO BLOB($picture;$xBlob;".jpg")
				//BLOB TO DOCUMENT($tFolderPath+$ptrNameField->+".jpg";$xBlob)
			End if 
		End if 
		//End if 
		//End if 
		
		NEXT RECORD:C51($ptrTable->)
	End for 
	
	
End if 

ALERT:C41("done")