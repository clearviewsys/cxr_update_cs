//%attributes = {}
// quit4DGetUPSConfigInfo
// Read a shutdown.ini file in order to get the shutdown config info
// This method needs to be included into the database startup method

ARRAY TEXT:C222($arrKeys; 0)
ARRAY TEXT:C222($arrValues; 0)
C_TEXT:C284(useUPSShutdown; $fileName)
C_BOOLEAN:C305($isOk)


// ---------------------------------------------------------------------------------------------------------
// Get the config information from the shutdown.ini file saved into Resources/config folder
// ---------------------------------------------------------------------------------------------------------

$fileName:=Get 4D folder:C485(Active 4D Folder:K5:10)+"shutdown.ini"
$isOk:=FT_ReadConfigFile($fileName; ->$arrKeys; ->$arrValues)

// Report EntityID (Defined by FIU)
useUPSShutdown:=FT_GetConfigValue("useUPSShutdown"; ->$arrKeys; ->$arrValues)

// Execute the process to know if we need to shutdown 4D when is requested by the UPS
If (useUPSShutdown="1")
	quitByShutDownLauncher
End if 

