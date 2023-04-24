//%attributes = {}
// AU_DownloadUpdates ( {->arrURLFilesToDownload}; {pathToSaveFiles}; {$upgradeStruc}; {$upgradeComp}; {$upgradeRes} ; {$upgradePlu} )

C_POINTER:C301($1; $arrFilesPtr)
C_TEXT:C284($2; $downloadPath)
C_BOOLEAN:C305($0; $3; $upgradeStruc; $4; $upgradeComp; $5; $upgradeRes; $6; $upgradePlu)

C_TEXT:C284($fileName)


C_BLOB:C604($blobFile)
C_LONGINT:C283($i; $error)
C_LONGINT:C283($p; $start; $lf)
C_TEXT:C284($inputStream; $output)
C_BOOLEAN:C305($abort)


ARRAY TEXT:C222($arrFileName; 0)
ARRAY TEXT:C222($arrTmp; 0)
ARRAY TEXT:C222($arrKeys; 0)

$upgradeStruc:=True:C214
$upgradeComp:=False:C215
$upgradeRes:=False:C215
$upgradePlu:=False:C215
$abort:=False:C215

$arrFilesPtr:=->$arrFileName


Case of 
		
	: (Count parameters:C259=0)
		
		APPEND TO ARRAY:C911($arrFileName; getKeyValue("au.url.update.latestversion"; "www.clearviewsys.com/updates/CXR/LatestVersion.zip"))
		APPEND TO ARRAY:C911($arrFileName; getKeyValue("au.url.update.datafiles"; "www.clearviewsys.com/updates/CXR/DataFiles_Generic.zip"))
		
		
	: (Count parameters:C259=1)
		
		$arrFilesPtr:=$1
		$upgradeStruc:=True:C214
		
		If ($upgradeStruc)
			APPEND TO ARRAY:C911($arrFileName; getKeyValue("au.url.update.latestversion"; "www.clearviewsys.com/updates/CXR/LatestVersion.zip"))
			APPEND TO ARRAY:C911($arrFileName; getKeyValue("au.url.update.datafiles"; "www.clearviewsys.com/updates/CXR/DataFiles_Generic.zip"))
		End if 
		
		
		
	: (Count parameters:C259=2)
		
		$arrFilesPtr:=$1
		$downloadPath:=$2
		
		
	: (Count parameters:C259=3)
		
		$arrFilesPtr:=$1
		$downloadPath:=$2
		$upgradeStruc:=$3
		
		If ($upgradeStruc)
			APPEND TO ARRAY:C911($arrFileName; getKeyValue("au.url.update.latestversion"; "www.clearviewsys.com/updates/CXR/LatestVersion.zip"))
			APPEND TO ARRAY:C911($arrFileName; getKeyValue("au.url.update.datafiles"; "www.clearviewsys.com/updates/CXR/DataFiles_Generic.zip"))
		End if 
		
	: (Count parameters:C259=4)
		
		$arrFilesPtr:=$1
		$downloadPath:=$2
		
		$upgradeStruc:=$3
		$upgradeComp:=$4
		
		If ($upgradeStruc)
			APPEND TO ARRAY:C911($arrFileName; getKeyValue("au.url.update.latestversion"; "www.clearviewsys.com/updates/CXR/LatestVersion.zip"))
			APPEND TO ARRAY:C911($arrFileName; getKeyValue("au.url.update.datafiles"; "www.clearviewsys.com/updates/CXR/DataFiles_Generic.zip"))
		End if 
		
		If ($upgradeComp)
			APPEND TO ARRAY:C911($arrFileName; getKeyValue("au.url.update.components"; "www.clearviewsys.com/updates/CXR/Components.zip"))
		End if 
		
		
		
	: (Count parameters:C259=5)
		
		$arrFilesPtr:=$1
		$downloadPath:=$2
		
		$upgradeStruc:=$3
		$upgradeComp:=$4
		$upgradeRes:=$5
		
		If ($upgradeStruc)
			APPEND TO ARRAY:C911($arrFileName; getKeyValue("au.url.update.latestversion"; "www.clearviewsys.com/updates/CXR/LatestVersion.zip"))
			APPEND TO ARRAY:C911($arrFileName; getKeyValue("au.url.update.datafiles"; "www.clearviewsys.com/updates/CXR/DataFiles_Generic.zip"))
		End if 
		
		If ($upgradeComp)
			APPEND TO ARRAY:C911($arrFileName; getKeyValue("au.url.update.components"; "www.clearviewsys.com/updates/CXR/Components.zip"))
		End if 
		
		If ($upgradeRes)
			APPEND TO ARRAY:C911($arrFileName; getKeyValue("au.url.update.resources"; "www.clearviewsys.com/updates/CXR/Resources.zip"))
		End if 
		
		
	: (Count parameters:C259=6)
		
		$arrFilesPtr:=$1
		$downloadPath:=$2
		
		$upgradeStruc:=$3
		$upgradeComp:=$4
		$upgradeRes:=$5
		$upgradePlu:=$6
		
		If ($upgradeStruc)
			APPEND TO ARRAY:C911($arrFileName; getKeyValue("au.url.update.latestversion"; "www.clearviewsys.com/updates/CXR/LatestVersion.zip"))
			APPEND TO ARRAY:C911($arrFileName; getKeyValue("au.url.update.datafiles"; "www.clearviewsys.com/updates/CXR/DataFiles_Generic.zip"))
		End if 
		
		If ($upgradeComp)
			APPEND TO ARRAY:C911($arrFileName; getKeyValue("au.url.update.components"; "www.clearviewsys.com/updates/CXR/Components.zip"))
		End if 
		
		If ($upgradeRes)
			APPEND TO ARRAY:C911($arrFileName; getKeyValue("au.url.update.resources"; "www.clearviewsys.com/updates/CXR/Resources.zip"))
		End if 
		
		If ($upgradePlu)
			APPEND TO ARRAY:C911($arrFileName; getKeyValue("au.url.update.plugins"; "www.clearviewsys.com/updates/CXR/Plugins.zip"))
		End if 
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// Create Download Path if doesn't exist
If (Test path name:C476($downloadPath)#Is a folder:K24:2)
	CREATE FOLDER:C475($downloadPath)
End if 


// Get absolut paths of the zipped update documents
DOCUMENT LIST:C474($downloadPath; $arrTmp; Absolute path:K24:14)

// Delete existing documents from path
For ($i; 1; Size of array:C274($arrTmp))
	DELETE DOCUMENT:C159($arrTmp{$i})
End for 

For ($i; 1; Size of array:C274($arrFilesPtr->))
	
	If (Not:C34($abort))
		
		$fileName:=$downloadPath+Folder separator:K24:12+getFileNameFromURL($arrFilesPtr->{$i})
		
		If (False:C215)
			
			//$cmd:=AU_CreateCurlCmd ($arrFilesPtr->{$i};$fileName)
			//SET ENVIRONMENT VARIABLE("_4D_OPTION_HIDE_CONSOLE";"true")
			//SET ENVIRONMENT VARIABLE("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS";"true")  // Sync Mode
			//LAUNCH EXTERNAL PROCESS($cmd;$inputStream;$outputStream;$errorStream)
			//UTIL_Log ("AutomaticUpdates";"Command executed: "+$cmd)
			
		Else   //IBB 9/24/18 b/c some sites do not have CURL
			C_TEXT:C284($tURL)
			C_BLOB:C604($xBlob)
			C_LONGINT:C283($iError)
			iH_Notify("Info"; "Downloading new version ..."; 90)
			$iError:=HTTP Get:C1157($arrFilesPtr->{$i}; $xBlob)
			
			If ($iError=200)
				BLOB TO DOCUMENT:C526($fileName; $xBlob)
				iH_Notify("Info"; "New version downloaded..."; 40)
			Else 
				$abort:=True:C214
			End if 
		End if 
		
		
		UTIL_Log("AutomaticUpdates"; "Document downloaded in: "+$fileName)
		
	Else 
		$i:=Size of array:C274($arrFilesPtr->)+1  // Exit Loop
	End if 
	
End for 

$0:=Not:C34($abort)
