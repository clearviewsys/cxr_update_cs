//%attributes = {}
// exportDaily (->[TABLE];->booleanField)
C_POINTER:C301($tablePtr; $1)
C_POINTER:C301($fieldPtr; $2)  // boolean pointer

C_OBJECT:C1216($status)


C_BLOB:C604(vexportTemplate)
C_TIME:C306(vhDocRef)
Case of 
	: (Count parameters:C259=0)
		$tablePtr:=->[Registers:10]
		$fieldPtr:=->[Registers:10]isExported:44
	Else 
		$tablePtr:=$1
		$fieldPtr:=$2
End case 

QUERY:C277($tablePtr->; $fieldPtr->=False:C215)  // find all the 
orderByTable($tablePtr)

setErrorTrap("importExportTable")
vhDocRef:=Open document:C264(getImportExportFilePath($tablePtr))  // Open a document called importNAVsTemplate 

If (OK=1)
	CLOSE DOCUMENT:C267(vhDocRef)  // Close the document   
	DOCUMENT TO BLOB:C525(Document; vexportTemplate)
	If (OK=0)
		myAlert("Error in opening the transfer template (BLOB conversion)")  // handler error
	End if 
	C_TEXT:C284($exportPath; $exportFileName)
	$exportPath:=makeDailyExportPath($tablePtr)
	SHOW ON DISK:C922($exportPath)
	EXPORT DATA:C666($exportPath; vexportTemplate)
	If (OK=1)  // successful export
		READ WRITE:C146($tablePtr->)
		APPLY TO SELECTION:C70($tablePtr->; $fieldPtr->:=True:C214)
		// check for locked records
		$status:=ftpUpload($exportPath)
	End if 
Else 
	myAlert("Cannot open"+$exportFileName+"; export template files may have been moved (from the CX_Support).")
End if 

endErrorTrap


