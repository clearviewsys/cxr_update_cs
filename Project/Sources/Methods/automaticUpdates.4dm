//%attributes = {}
// automaticUpdates
// Execute an automatic Update downloading a new version from Github Repository
// 
//
// -------------------------------------------------------------------------------
//  Check if Download folder exists
// -------------------------------------------------------------------------------

ARRAY TEXT:C222($arrHeader; 0)
ARRAY TEXT:C222($arrFileName; 0)
ARRAY TEXT:C222($arrHeaderValues; 0)

// -------------------------------------------------------------------------------
//  Variable Definition
// -------------------------------------------------------------------------------

var $status : Integer
var $ok1; $ok2; $ok3; $isFolderOk : Boolean

var $latestVersionDownloaded; $zipURL; $ramdomFileName : Text
var $currentVersion; $newVersion; $tempFolder; $url; $tag; $newStructureFile : Text

var $headers; $requestParameters; $emptyObj; $response; $cmd : Object
var $win4DServiceName; $logPath; $logFileName; $logFilePath; $repositoryURL; $downloadPath : Text

var $newVersionFullPath : Text


$win4DServiceName:=getKeyValue("au.Service.Name"; "4DS_CXR7")
$logFileName:=getKeyValue("au.LogFileName"; "AutomaticUpdates")
$logPath:=Get 4D folder:C485(Logs folder:K5:19)

$logFilePath:=$logPath+$logFileName
$downloadPath:=getFilePathByID("au.download.path")

UTIL_Log(Current method name:C684; "-----------------------------------------------------------------------------------------")
UTIL_Log(Current method name:C684; "Starting Automatic Update process ..."+String:C10(Current date:C33(*))+"-"+String:C10(Current time:C178(*)))

// -------------------------------------------------------------------------------
//  Check if Download folder exists
// -------------------------------------------------------------------------------

$isFolderOk:=checkDownloadFolder($logFilePath; ->$downloadPath)

If ($isFolderOk)
	
	// -------------------------------------------------------------------------------
	// Define Headers for the HTTP Request including Token (must be created in GitHub)
	// -------------------------------------------------------------------------------
	AU_SetGitHubApiHeaders(->$arrHeader; ->$arrHeaderValues)
	
	// -------------------------------------------------------------------------------
	// Make a call to get the latest version tag
	// -------------------------------------------------------------------------------
	
	$repositoryURL:=getKeyValue("AU.GitHubRepo"; "https://api.github.com/repos/clearviewsys/cxr_update_cs/releases/latest")
	UTIL_Log(Current method name:C684; "Getting lates version from: "+$repositoryURL+" ...")
	UTIL_Log(Current method name:C684; "Getting latest tag from Github ...")
	$status:=HTTP Request:C1158(HTTP GET method:K71:1; $repositoryURL; $emptyObj; $response; $arrHeader; $arrHeaderValues)
	
	If ($status=200)
		
		If ($response.tag_name>getBuild)
			
			UTIL_Log(Current method name:C684; "Installed version "+$response.tag_name)
			UTIL_Log(Current method name:C684; "Installed version "+getBuild)
			
			// $url:="https://github.com/clearviewsys/cxr_update_cs/archive/refs/tags/"+$response.tag_name+".zip"
			
			$url:=getKeyValue("AU.GitTagURL"; "https://github.com/clearviewsys/cxr_update_cs/archive/refs/tags/")
			$url:=$url+$response.tag_name+".zip"
			$ramdomFileName:="latestVersion_"+String:C10(Random:C100)+".zip"
			
			UTIL_Log(Current method name:C684; "Downloading Zip file from GitHub ...")
			APPEND TO ARRAY:C911($arrFileName; $url)
			
			
			// Download new version
			$ok1:=AU_DownloadUpdates(->$arrFileName; $downloadPath)
			
			// Unzip new version
			$ok2:=AU_UnzipFilesV2($downloadPath; $response.tag_name+".zip"; ->$newStructureFile; ->$newVersionFullPath)
			
			If ($ok1 & $ok2)
				
				UTIL_Log(Current method name:C684; "Unzipping process of the file: "+$response.tag_name+" was successful")
				iH_Notify("Info"; "Restarting 4D ..."; 10)
				
				//SET UPDATE FOLDER($newVersionFullPath+Folder separator; True)
				//RESTART 4D
				
			Else 
				
				Case of 
						
					: (Not:C34($ok1))
						UTIL_Log(Current method name:C684; "It was not possible to Download to the new release!")
						
					: (Not:C34($ok2))
						UTIL_Log(Current method name:C684; "It was not possible to Unzip to the new release!")
						
				End case 
				
				
			End if 
			
		End if 
		
	Else 
		UTIL_Log(Current method name:C684; "It was not possible to get the latest version from github!")
	End if 
End if 

