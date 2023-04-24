//%attributes = {}
#DECLARE($csvFile : Text; $useOracleSeparator : Boolean)->$jsonFile : Text

var $jqPath; $csvConverterPath; $cmd : Text
var $csvFileObj; $outFile : Object
var $in; $out; $err : Text

If (Count parameters:C259=1)
	$useOracleSeparator:=False:C215
End if 

// We are using filePaths now

// Download jq binaries from: https://stedolan.github.io/jq/download/
// jq playground site: https://jqplay.org

//If (Is macOS)
//$jqPath:=Get 4D folder(Current resources folder)+"jq"+Folder separator+"jq-osx-amd64"  // key-value in the future?
//Else 
//// $jqPath:=Get 4D folder(Current resources folder)+"jq"+Folder separator+"jq-win32.exe"
//$jqPath:=Get 4D folder(Current resources folder)+"jq"+Folder separator+"jq-win64.exe"
//End if 

$jqPath:=getFilePathByID("jq.download.path")

If (Test path name:C476($jqPath)#Is a folder:K24:2)
	$jqPath:=Get 4D folder:C485(Current resources folder:K5:16)+"jq"+Folder separator:K24:12
End if 

If (Test path name:C476($jqPath)=Is a folder:K24:2)
	
	If (Is macOS:C1572)
		$jqPath:=$jqPath+"jq-osx-amd64"
	Else 
		$jqPath:=$jqPath+"jq-win64.exe"
	End if 
	
	If ($useOracleSeparator)
		$csvConverterPath:=Get 4D folder:C485(Current resources folder:K5:16)+"jq"+Folder separator:K24:12+"csv2jsonForOracle.jq"
	Else 
		$csvConverterPath:=Get 4D folder:C485(Current resources folder:K5:16)+"jq"+Folder separator:K24:12+"csv2json.jq"
	End if 
	
	$csvFileObj:=File:C1566($csvFile; fk platform path:K87:2)
	$outFile:=File:C1566($csvFileObj.parent.platformPath+$csvFileObj.name+".json"; fk platform path:K87:2)
	
	$jsonFile:=$outFile.platformPath
	
	If (Test path name:C476($jsonFile)=Is a document:K24:1)  //@ibb added otherwise will fail conversion
		DELETE DOCUMENT:C159($jsonFile)
	End if 
	
	If (Is macOS:C1572)
		
		// jq doesn't support redirecting the output to a file
		// $cmd:=Convert path system to POSIX($jqPath)+"  -R -s -f "+Convert path system to POSIX($csvConverterPath)+" "+\
														Convert path system to POSIX($csvFile)+" > "+Convert path system to POSIX($jsonFile)
		
		$cmd:=Convert path system to POSIX:C1106($jqPath)+"  -R -s -f "+\
			Convert path system to POSIX:C1106($csvConverterPath)+" "+\
			Convert path system to POSIX:C1106($csvFile)
		
		//If (false)  // a way to redirect output from jq to a file
		//$cmd:="/bin/zsh "+$cmd+" | cat > "+Convert path system to POSIX($jsonFile)
		//End if 
		
	Else 
		
		$cmd:=$jqPath+"  -R -s -f "+$csvConverterPath+" "+$csvFile
		
	End if 
	
	LAUNCH EXTERNAL PROCESS:C811($cmd; $in; $out; $err)
	
	If ($out#"")
		
		TEXT TO DOCUMENT:C1237($jsonFile; $out; "UTF-8")
		
	End if 
	
End if 
