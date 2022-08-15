//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jonathan Le
// Date and time: 03/31/04, 10:36:14
// ----------------------------------------------------
// Method: BKP_XML_GetParentElem
// Description
//
// Returns the parent node of the backup.xml file 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0)

// get the platform directory glyph
C_TEXT:C284($tDirSymbol)
$tDirSymbol:=BKP_GetDirGlyph

// test the backup path
C_BOOLEAN:C305($bTestOK)
C_TEXT:C284($tBackupFile; $tBackupFileName)
$tBackupFileName:=<>tBackupFileName
$bTestOK:=(Test path name:C476($tBackupFileName)=1)

If ($bTestOK)
	
	C_TEXT:C284($tParentElem)
	C_BLOB:C604($xBackupFile)
	C_TIME:C306($tiDocRef)
	
	$tiDocRef:=Open document:C264($tBackupFileName)
	CLOSE DOCUMENT:C267($tiDocRef)
	DOCUMENT TO BLOB:C525(Document; $xBackupFile)
	
	$tParentElem:=DOM Parse XML variable:C720($xBackupFile)
	
	$0:=$tParentElem
	
Else 
	
	$0:=""
	
End if 