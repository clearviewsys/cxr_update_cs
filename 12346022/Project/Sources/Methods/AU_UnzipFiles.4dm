//%attributes = {}
// AU_UnzipFiles( {path} )
// Unzip all .zip files from a given path

C_TEXT:C284($1; $pathToFiles; $path)
C_LONGINT:C283($i)
C_TEXT:C284($newStructure)
C_POINTER:C301($2; $newStructurePtr)
C_BOOLEAN:C305($0; $abort)

$newStructure:=""
$0:=False:C215
$abort:=False:C215


Case of 
		
	: (Count parameters:C259=0)
		$pathToFiles:=getKeyValue("au.download.path"; System folder:C487(Desktop:K41:16)+"CXR_NewRelease"+Folder separator:K24:12)
		
	: (Count parameters:C259=1)
		$pathToFiles:=$1
		
	: (Count parameters:C259=2)
		$pathToFiles:=$1
		$newStructurePtr:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


C_TEXT:C284($file; $src; $dest)

// Check if Path exists
If (Test path name:C476($pathToFiles)=Is a folder:K24:2)
	
	// Get absolut paths of the zipped update documents
	DOCUMENT LIST:C474($pathToFiles; $arrFileNames; Absolute path:K24:14)
	
	// Unzip all .zip documents in folder $pathToFiles
	
	For ($i; 1; Size of array:C274($arrFileNames))
		
		
		If (Is macOS:C1572)
			
			$file:=Convert path system to POSIX:C1106($arrFileNames{$i})
			LAUNCH EXTERNAL PROCESS:C811("open \""+$file+"\"")
			UTIL_Log("AutomaticUpdates"; " File unzipped: "+$file)
		Else 
			
			//$command:=Char(Double quote)+AU_Get7ZipPath +Char(Double quote)+" x "
			//$command:=$command+Char(Double quote)+Convert path system to POSIX($arrFileNames{$i})+Char(Double quote)
			//$command:=$command+" -y -o"+Char(Double quote)+Convert path system to POSIX($pathToFiles)+Char(Double quote)
			//
			//SET ENVIRONMENT VARIABLE("_4D_OPTION_HIDE_CONSOLE";"true")
			//SET ENVIRONMENT VARIABLE("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS";"true")  // Sync Mode
			//LAUNCH EXTERNAL PROCESS($command)
			// UTIL_Log ("AutomaticUpdates";"Command executed:"+$command)
			
			$src:=Convert path system to POSIX:C1106($arrFileNames{$i})
			$dest:=Convert path system to POSIX:C1106($pathToFiles)
			
			If ((AU_UnzipPHP($src; $dest) & Not:C34($abort)))
				UTIL_Log("AutomaticUpdates"; "File unzipped: "+$arrFileNames{$i})
				DELETE DOCUMENT:C159($arrFileNames{$i})
				UTIL_Log("AutomaticUpdates"; "File Deleted: "+$arrFileNames{$i})
			Else 
				UTIL_Log("AutomaticUpdates"; "File cannot be unzipped: "+$arrFileNames{$i})
				$abort:=True:C214
			End if 
			
		End if 
		
	End for 
	
	$newStructure:=""
	
	DOCUMENT LIST:C474($pathToFiles; $arrFileNames; Absolute path:K24:14)
	For ($i; 1; Size of array:C274($arrFileNames))
		If (Position:C15(".4DB"; $arrFileNames{$i})>0)
			$newStructure:=getFileName($arrFileNames{$i})
			$i:=Size of array:C274($arrFileNames)+1
		End if 
	End for 
	
	
End if 


If ($newStructure#"")
	$newStructurePtr->:=$newStructure
Else 
	$newStructurePtr->:=UTIL_LongNameToFileName(Structure file:C489)  // Get the current structure Name
End if 

$0:=Not:C34($abort)

