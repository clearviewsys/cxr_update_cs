//%attributes = {}
// ----------------------------------------------------
// Method: FILE_Copy_Folder
// Description
// This is the recursive copy
//
// Parameters
// $1 is the origin path
//$2 is the backup path
// ----------------------------------------------------

C_TEXT:C284($1; $2; $vOrig; $vDest)

ARRAY TEXT:C222($aFolders1; 0)
ARRAY TEXT:C222($aFolders2; 0)
ARRAY TEXT:C222($aDocs1; 0)
ARRAY TEXT:C222($aDocs2; 0)

$vOrig:=$1
$vDest:=$2

DOCUMENT LIST:C474($vOrig; $aDocs1)  //find all files in the original folder

If (Test path name:C476($vDest)#Is a folder:K24:2)
	CREATE FOLDER:C475($vDest)
End if 

DOCUMENT LIST:C474($vDest; $aDocs2)  //find all files in the backup drive

//Message2 ("Folder copy in progress...")
C_LONGINT:C283($i)

For ($i; 1; Size of array:C274($aDocs1))  //loop through the original files
	If ((Find in array:C230($aDocs2; $aDocs1{$i})>0) | ($aDocs1{$i}=".DS_Store") | ($aDocs1{$i}="@desktop@"))  //if this file is in thebackup drive or if it's a .DS_Store file
		//ignore it
	Else 
		//otherwise, copy it over
		//Message2 ("Copying from : "+$vOrig+$aDocs1{$i}+Char(13)+"To : "+$vDest+$aDocs1{$i})
		COPY DOCUMENT:C541($vOrig+$aDocs1{$i}; $vDest+$aDocs1{$i}; *)
	End if 
End for 

FOLDER LIST:C473($vOrig; $aFolders1)
FOLDER LIST:C473($vDest; $aFolders2)

For ($i; 1; Size of array:C274($aFolders1))  //now loop through the folders
	If ((Find in array:C230($aFolders2; $aFolders1{$i})>0) | ($aFolders1{$i}="@...") | ($aFolders1{$i}="@trash@"))  //if this folder is in"the backup drive or it's the sweeper folder
		//ignore it
	Else 
		CREATE FOLDER:C475($vDest+$aFolders1{$i})
	End if 
	If (($aFolders1{$i}="@Cache@") | ($aFolders1{$i}="@trash@"))
		//don't copy anything in the cache or trash folder. Don't even go in it
	Else 
		FILE_Copy_Folder($vOrig+$aFolders1{$i}+Folder separator:K24:12; $vDest+$aFolders1{$i}+Folder separator:K24:12)
	End if 
End for 