//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jonathan Le
// Date and time: 04/02/04, 09:25:11
// ----------------------------------------------------
// Method: BKP_XML_Save
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TIME:C306($tiDocRef)
C_TEXT:C284($tPathName; $tFilename)
C_TEXT:C284($statusMessage)
C_TEXT:C284(<>tBackupPathName)
C_TEXT:C284(<>tBackupFileName)

// later on, it might be a good idea to back up before we do a save

$tPathname:=<>tBackupPathName
$tFilename:=<>tBackupFileName

If ((Test path name:C476($tPathname)=Is a folder:K24:2) & (Test path name:C476($tFilename)=Is a document:K24:1))
	$tiDocRef:=Create document:C266($tFilename)
	
	$tiDocRef:=BKP_XML_StartDocument($tiDocRef)
	
	// this is part of the DataBase group
	$tiDocRef:=BKP_XML_SaveInfo($tiDocRef)
	
	// all of the following are part of the Settings group
	SAX OPEN XML ELEMENT:C853($tiDocRef; "Settings")
	
	// advanced settings
	$tiDocRef:=BKP_XML_SaveAdvanced($tiDocRef)
	
	// general settings
	$tiDocRef:=BKP_XML_SaveGeneral($tiDocRef)
	
	// scheduler settings
	
	$tiDocRef:=BKP_XML_SaveScheduler($tiDocRef)
	
	SAX CLOSE XML ELEMENT:C854($tiDocRef)
	
	$tiDocRef:=BKP_XML_EndDocument($tiDocRef)
	
	CLOSE DOCUMENT:C267($tiDocRef)
	
	$statusMessage:="Backup XML saved."
Else 
	$statusMessage:="Backup XML not saved."
	
	If (Test path name:C476($tPathname)#Is a folder:K24:2)
		$statusMessage:=$statusMessage+Char:C90(Carriage return:K15:38)+"Preferences path not found."
	End if 
	
	If (Test path name:C476($tFilename)#Is a document:K24:1)
		$statusMessage:=$statusMessage+Char:C90(Carriage return:K15:38)+"No Backup XML file was opened."
	End if 
	
End if 

myAlert($statusMessage)