//%attributes = {}
// saveTextToFile(content;filename)

C_TEXT:C284($text; $1; $filename; $2)

$text:=$1
$fileName:=$2

C_TIME:C306($vhDocRef)
C_OBJECT:C1216($o)

$o:=Path to object:C1547($filename)

If (Test path name:C476($o.parentFolder)=Is a folder:K24:2)
	$vhDocRef:=Create document:C266($fileName)  // Create new document called Note 
	
	If (OK=1)
		SEND PACKET:C103($vhDocRef; $text)  // Write one word in the document 
		
		CLOSE DOCUMENT:C267($vhDocRef)  // Close the document 
		
	End if 
End if 