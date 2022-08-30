//%attributes = {}
// exportRecords (->[TABLE];boolean import(true)/export(false))
C_POINTER:C301($1)
C_BOOLEAN:C305($2)

C_BLOB:C604(vexportTemplate)
C_TIME:C306(vhDocRef)
C_TEXT:C284($action; $exportFileName)
If ($2)
	$action:="import"
Else 
	$action:="export"
End if 

setErrorTrap("importExportTable")
If (isUserAuthorizedToImportExport($1; $2))
	vhDocRef:=Open document:C264(getImportExportFilePath($1))  // Open a document called importNAVsTemplate 
	
	If (OK=1)
		CLOSE DOCUMENT:C267(vhDocRef)  // Close the document   
		DOCUMENT TO BLOB:C525(Document; vexportTemplate)
		If (OK=0)
			myAlert("Error in Converting Document to BLOB")  // handler error
		End if 
		If ($2)
			IMPORT DATA:C665(""; vExportTemplate; *)
		Else 
			EXPORT DATA:C666(""; vexportTemplate; *)
		End if 
	Else 
		myAlert("Cannot open"+$exportFileName+"; import/export setting files may have been moved.")
	End if 
Else 
	myAlert("Sorry, you are not authorized to "+$action+" data for table "+Table name:C256($1))
End if 

endErrorTrap

