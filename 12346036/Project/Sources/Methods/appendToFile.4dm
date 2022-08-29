//%attributes = {}

// AppendToFile ($fileName; $(text|Blob) Pointer; $CreateFile)
// Append a text or Blob to a $fileName

C_TEXT:C284($1; $fileName)
C_POINTER:C301($2)  // Content to append to file 
C_BOOLEAN:C305($3; $createFile)

Case of 
		
	: (Count parameters:C259=2)
		
		$fileName:=$1
		$createFile:=False:C215
		
	: (Count parameters:C259=3)
		
		$fileName:=$1
		$createFile:=$3
		
End case 


C_TIME:C306($doc)

If ($createFile)
	createFile($fileName)
End if 

$doc:=Append document:C265($fileName)

If (OK=1)
	SEND PACKET:C103($doc; $2->)
	CLOSE DOCUMENT:C267($doc)  // Close the document
End if 

