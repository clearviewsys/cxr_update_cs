//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jonathan Le & Tiran Behrouz
// opens the default backup file
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($tDefaultXPath; $tDirSymbol)
C_TEXT:C284($backupFilePath; $fileName; $backupFolderPath)
C_TIME:C306($documents)

BKP_InitializeGlobalVariables

$tDefaultXPath:="/Preferences4D/Backup"
$tDirSymbol:=BKP_GetDirGlyph
<>tDefaultXPath:=$tDefaultXPath

//ARRAY TEXT($documents;0)
//◊tBackupFileName:=Select document(Helper_GetPath (Structure file);".xml;XML";"Open Backup File";0;$documents)
$fileName:="backup.xml"
$backupFolderPath:=<>RootFolderPath+"Preferences"+pathSeparator+"Backup"
$backupFilePath:=$backupFolderPath+pathSeparator+$fileName
//$documents:=Open document($backupFilePath)
//CLOSE DOCUMENT($documents)


//If (OK=1)
// get the first document the user selected
<>tBackupFileName:=$backupFilePath
<>tBackupPathName:=$backupFolderPath

If (Test path name:C476(<>tBackupFileName)=1)
	BKP_XML_GetAllPreferences($tDefaultXPath)
	BKP_LaunchApp
Else 
	myAlert("Backup Preferences were not found!")
End if 
//Else 
//ALERT("Cannot find "+$backupPath)
//End if 