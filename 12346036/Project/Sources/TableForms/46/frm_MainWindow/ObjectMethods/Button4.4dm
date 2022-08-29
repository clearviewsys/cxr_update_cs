C_TEXT:C284($tDocument)
ARRAY TEXT:C222($aSelected; 0)

// prompt the user to select a document

$tDocument:=Select document:C905(""; ""; "Select a file to attach"; 0; $aSelected)

// add the selected document to the list, which is the first file

If ($tDocument#"")
	APPEND TO ARRAY:C911(IncludesFiles; $aSelected{1})
End if 