//%attributes = {}
// AU_UnzipFilesV2( {path} )
// Unzip all .zip files from a given path

var $1; $pathToFiles; $2; $zipFileName : Text
var $3; $newStructurePtr; $4; $newVersionFullPathPtr : Pointer

ARRAY TEXT:C222($arrFileNames; 0)
ARRAY TEXT:C222($arrFolders; 0)
ARRAY TEXT:C222($arrFolders; 0)

var $i : Integer
var $file; $src; $dest : Text
var $newStructure; $path; $tmp : Text
var $pathObj; $folder; $archive; $folderResult : Object

$newStructure:=""

Case of 
		
	: (Count parameters:C259=4)
		
		$pathToFiles:=$1
		$zipFileName:=$2
		$newStructurePtr:=$3
		$newVersionFullPathPtr:=$4
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


// Check if Path exists
If (Test path name:C476($pathToFiles)=Is a folder:K24:2)
	
	// Get absolut paths of the zipped update documents
	DOCUMENT LIST:C474($pathToFiles; $arrFileNames; Absolute path:K24:14)
	
	
	iH_Notify("Info"; "Unzipping new version ..."; 10)
	
	// Unzip all .zip documents in folder $pathToFiles
	$pathObj:=Folder:C1567(fk desktop folder:K87:19).file("_downloads/"+$zipFileName)
	$archive:=ZIP Read archive:C1637($pathObj)
	iH_Notify("Info"; "New version Unzipped..."; 10)
	$folder:=$archive.root.folders()[0]
	
	$folderResult:=$archive.root.copyTo(Folder:C1567(fk desktop folder:K87:19).folder("_downloads"))
	
	$pathToFiles:=System folder:C487(Desktop:K41:16)+"_downloads"+Folder separator:K24:12+$zipFileName
	$pathToFiles:=Replace string:C233($pathToFiles; ".zip"; "")+Folder separator:K24:12+$folder.fullName
	// $pathToFiles contains: v7.000_build_1008/cxr_update_cs-7.000_build_1008
	//+Folder separator+"CXR7"
	
	FOLDER LIST:C473($pathToFiles; $arrFolders)
	
	$newStructure:=""
	
	
	DOCUMENT LIST:C474($pathToFiles; $arrFileNames; Absolute path:K24:14)
	
	For ($i; 1; Size of array:C274($arrFileNames))
		
		If (Position:C15(".4DZ"; $arrFileNames{$i})>0)
			$newStructure:=getFileName($arrFileNames{$i})
			$i:=Size of array:C274($arrFileNames)+1
		End if 
		
	End for 
End if 

$newVersionFullPathPtr->:=$pathToFiles

If ($newStructure#"")
	$newStructurePtr->:=$newStructure
Else 
	$newStructurePtr->:=UTIL_LongNameToFileName(Structure file:C489)  // Get the current structure Name
End if 

// Return true if download was successfull

If (Test path name:C476($newVersionFullPathPtr->+Folder separator:K24:12+$newStructure)=Is a document:K24:1)
	$0:=True:C214
Else 
	$0:=False:C215
End if 

