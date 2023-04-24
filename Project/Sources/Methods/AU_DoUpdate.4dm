//%attributes = {"shared":true}
// AU_DoUpdate ({$upgradeStruc=true};{$upgradeComp};{$upgradeRes};{$upgradePlu})
// Execute the Automatic Update. If $fullUpdate=true will execute a Full Update (Structure, Components, Plugins and Resources) 
// else only the structure 



C_BOOLEAN:C305($1; $upgradeStruc)
C_BOOLEAN:C305($2; $upgradeComp; $3; $upgradeRes; $4; $upgradePlu)

C_LONGINT:C283($pID)
C_TEXT:C284($updateFolder)
ARRAY TEXT:C222($arrFileName; 0)
var $logFileName; $logPath; $logFilePath; $newStructureFile : Text

$newStructureFile:=""

$upgradeStruc:=True:C214
$upgradeComp:=False:C215
$upgradeRes:=False:C215
$upgradePlu:=False:C215


Case of 
	: (Count parameters:C259=0)
		
		$upgradeStruc:=True:C214
		
	: (Count parameters:C259=1)
		
		$upgradeStruc:=$1
		
	: (Count parameters:C259=2)
		
		$upgradeStruc:=$1
		$upgradeComp:=$2
		
	: (Count parameters:C259=3)
		
		$upgradeStruc:=$1
		$upgradeComp:=$2
		$upgradeRes:=$3
		
	: (Count parameters:C259=4)
		
		$upgradeStruc:=$1
		$upgradeComp:=$2
		$upgradeRes:=$3
		$upgradePlu:=$4
		
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
C_TEXT:C284($auEnabled; $downloadFolder)
C_BOOLEAN:C305($ok1; $ok2; $ok3)

UTIL_Log("AutomaticUpdates"; " ")
UTIL_Log("AutomaticUpdates"; "----------------------------------------------------------------------------------------------------")
UTIL_Log("AutomaticUpdates"; " ")


$auEnabled:=getKeyValue("au.automatic_updates_allowed"; "true")

If ($auEnabled="true")
	
	
	// ----------------------------------------------------------------------------
	// Create Log file if not exists
	// ----------------------------------------------------------------------------
	$logFileName:=getKeyValue("au.LogFileName"; "AutomaticUpdates")
	$logPath:=Get 4D folder:C485(Logs folder:K5:19)
	$logFilePath:=$logPath+$logFileName
	$downloadFolder:=getFilePathByID("au.download.path")
	
	UTIL_Log("AutomaticUpdates"; "Automatic Update process started")
	
	
	// ----------------------------------------------------------------------------
	// Config the URL's where are the new zipped files.
	// ----------------------------------------------------------------------------
	
	APPEND TO ARRAY:C911($arrFileName; getKeyValue("au.url.update.datafiles"; "www.clearviewsys.com/updates/CXR/DataFiles_Generic.zip"))
	
	
	If ($upgradeStruc)
		APPEND TO ARRAY:C911($arrFileName; getKeyValue("au.url.update.latestversion"; "www.clearviewsys.com/updates/CXR/LatestVersion.zip"))
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
	
	
	// ----------------------------------------------------------------------------
	// Download the new release and execute the Update
	// ----------------------------------------------------------------------------
	
	
	If (Not:C34(isDevelopmentEnv))
		
		
		$ok1:=AU_DownloadUpdates(->$arrFileName; $downloadFolder)
		
		$ok2:=AU_UnzipFiles($downloadFolder; ->$newStructureFile)
		
		$ok3:=AU_MakeUpdate($newStructureFile; $upgradeStruc; $upgradeComp; $upgradeRes; $upgradePlu)
		
		If ($ok1 & $ok2 & $ok3)
			// All OK
		Else 
			UTIL_Log("AutomaticUpdates"; "It was not possible to Upgrade the Development Release!")
		End if 
		
		
	End if 
	
	
Else 
	UTIL_Log("AutomaticUpdates"; "Updates are not enabled, please enable it on Key Values")
End if 

