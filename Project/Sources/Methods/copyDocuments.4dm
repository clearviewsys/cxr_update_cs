//%attributes = {}
C_TEXT:C284($1; $2; $sourcePath; $targetPath)
C_BOOLEAN:C305($3; $replace)

C_LONGINT:C283($i)
C_TEXT:C284($targetFile; $sourcePath; $fileName; $currErrMethod)

ARRAY TEXT:C222($arrFiles; 0)

$sourcePath:=$1+Folder separator:K24:12
$sourcePath:=Replace string:C233($sourcePath; Folder separator:K24:12+Folder separator:K24:12; Folder separator:K24:12)
$sourcePath:=Replace string:C233($sourcePath; Folder separator:K24:12+Folder separator:K24:12; Folder separator:K24:12)

$targetPath:=$2+Folder separator:K24:12
$targetPath:=Replace string:C233($targetPath; Folder separator:K24:12+Folder separator:K24:12; Folder separator:K24:12)
$targetPath:=Replace string:C233($targetPath; Folder separator:K24:12+Folder separator:K24:12; Folder separator:K24:12)

If (Count parameters:C259>=3)
	$replace:=$3
Else 
	$replace:=False:C215
End if 


$currErrMethod:=Method called on error:C704
ON ERR CALL:C155("errorIgnore")

If (Test path name:C476($targetPath)#Is a folder:K24:2)
	CREATE FOLDER:C475($targetPath)
End if 


If (Test path name:C476($targetPath)=Is a folder:K24:2)  //
	DOCUMENT LIST:C474($sourcePath; $arrFiles)
	
	For ($i; 1; Size of array:C274($arrFiles))
		
		$fileName:=$arrFiles{$i}
		//$targetFile:=Replace string($targetFile;Folder separator+Folder separator;Folder separator)
		
		If (Test path name:C476($targetPath+$fileName)=Is a document:K24:1) & ($replace=False:C215)
			MOVE DOCUMENT:C540($targetPath+$fileName; $targetPath+"BK_"+String:C10(Random:C100)+"_"+$fileName)
		End if 
		
		If (Test path name:C476($targetPath)=Is a folder:K24:2)
			COPY DOCUMENT:C541($sourcePath+$fileName; $targetPath+$fileName; *)
		End if 
		
	End for 
	
	// Copy other folders if they exists
	
	
	FOLDER LIST:C473($sourcePath; $arrFolder)
	For ($i; 1; Size of array:C274($arrFolder))
		copyDocuments($sourcePath+$arrFolder{$i}; $targetPath+$arrFolder{$i}; $replace)
	End for 
End if 

ON ERR CALL:C155($currErrMethod)