//%attributes = {}
// checks if there is directory.json file in locations 4D will recognize and use
// for default users and groups and copies it from RESOURCES folder into proper location
// so the next time application starts there will be passwords defined for Designer and
// Administrator users

#DECLARE->$status : Object

var $structPath; $dataFileSettingsFolder; $structSettingsFolder : Object
var $dataDirFile; $resDirJSONFile; $structDirFile; $resourcesDir : Object
var $moveFile : Boolean
var $destFileName; $json : Text
var $decryptMe : Blob

$status:=New object:C1471
$status.dirJSONFileCopied:=False:C215
$status.dirJSONFileExists:=False:C215
$status.settingsFolderCreated:=False:C215

$moveFile:=True:C214

// $status.dirJSONFileUsed:=File object
// $status.directoryJSON:="data|struct_project|struct_4dz"

If (Application type:C494#4D Remote mode:K5:5)
	
	UTIL_Log("dirjson"; "not 4D Remote")
	
	$resourcesDir:=Folder:C1567(fk resources folder:K87:11)
	$structPath:=getServerStructurePathObject
	
	// TRACE
	
	$dataFileSettingsFolder:=Folder:C1567(Folder:C1567(fk data folder:K87:12).platformPath+"Settings"; fk platform path:K87:2)
	$dataDirFile:=File:C1566($dataFileSettingsFolder.platformPath+"directory.json"; fk platform path:K87:2)
	
	UTIL_Log("dirjson"; "Resources folder is "+$resourcesDir.platformPath)
	UTIL_Log("dirjson"; "dataFileSettings folder is "+$dataFileSettingsFolder.platformPath)
	UTIL_Log("dirjson"; "dataDirFile is "+$dataDirFile.platformPath)
	
	If ($dataFileSettingsFolder.exists)
		UTIL_Log("dirjson"; "settings folder in data folder present in "+$dataFileSettingsFolder.platformPath)
		If ($dataDirFile.exists)
			UTIL_Log("dirjson"; "directory.json in settings folder in data folder present in "+$dataDirFile.platformPath)
			$moveFile:=False:C215
			$status.dirJSONFileUsed:=JSON Stringify:C1217($dataDirFile; *)
			$status.directoryJSON:="data"
		Else 
			UTIL_Log("dirjson"; "No directory.json in settings folder in data folder")
		End if 
	Else 
		CREATE FOLDER:C475($dataFileSettingsFolder.platformPath)
		UTIL_Log("dirjson"; "Created folder: "+$dataFileSettingsFolder.platformPath)
		
	End if 
	
	$destFileName:="nosj.yrotcerid"
	$resDirJSONFile:=File:C1566($resourcesDir.platformPath+$destFileName; fk platform path:K87:2)
	
	If ($resDirJSONFile.exists)
		
		UTIL_Log("dirjson"; "nosj.yrotcerid exist")
		
		// get the contents
		
		DOCUMENT TO BLOB:C525($resDirJSONFile.platformPath; $decryptMe)
		$json:=UTIL_Decrypt($decryptMe)
		
		If (Application type:C494=4D Volume desktop:K5:2)
			
			// standalone, do not change content of the app itself, save file next to data file
			UTIL_Log("dirjson"; "I am in engined app")
			TEXT TO DOCUMENT:C1237($dataDirFile.platformPath; $json; "UTF-8")
			$status.dirJSONFileCopied:=True:C214
			
		Else 
			
			If ($moveFile)
				
				UTIL_Log("dirjson"; "about to move file")
				
				If (($structPath.extension=".4DProject") | ($structPath.extension=".4DZ"))
					
					Case of 
							
						: ($structPath.extension=".4DProject")
							
							$structSettingsFolder:=Folder:C1567(Folder:C1567($structPath.parentFolder; fk platform path:K87:2).parent.platformPath+"Settings"; fk platform path:K87:2)
							$status.directoryJSON:="struct_project"
							
							
						: ($structPath.extension=".4DZ")
							
							$structSettingsFolder:=Folder:C1567($structPath.parentFolder+"Settings"; fk platform path:K87:2)
							$status.directoryJSON:="struct_4dz"
							
						Else 
							
							$status.directoryJSON:="none"
							
					End case 
					
					If (Not:C34($structSettingsFolder.exists))
						CREATE FOLDER:C475($structSettingsFolder.platformPath)
						$status.settingsFolderCreated:=True:C214
					End if 
					
					$structDirFile:=File:C1566($structSettingsFolder.platformPath+"directory.json"; fk platform path:K87:2)
					$status.dirJSONFileUsed:=$structDirFile
					
					If (Not:C34($structDirFile.exists))
						TEXT TO DOCUMENT:C1237($structDirFile.platformPath; $json; "UTF-8")
						$status.dirJSONFileCopied:=True:C214
					End if 
					
				End if   // If (($structPath.extension=".4DProject") | ($structPath.extension=".4DZ"))
				
			End if   // If ($moveFile)
			
			
		End if   // If (Application type=4D Volume desktop)
		
	Else 
		
		UTIL_Log("dirjson"; "nosj.yrotcerid not present in Resources folder")
		
	End if   // If ($resDirJSONFile.exists)
	
End if   // If (Application type#4D Remote mode)

UTIL_Log("dirjson"; JSON Stringify:C1217($status; *))
