//%attributes = {}
// createFile ($fileName)
// Creates the file $filename (Path included)


C_TEXT:C284($1; $fileName)
C_TIME:C306($doc)

$fileName:=$1

$doc:=Create document:C266($fileName)
If (OK=1)
	CLOSE DOCUMENT:C267($doc)  // Close the document
End if 

