//%attributes = {}
// ------------------------------------------------------------------------------
// Method: readXMLFile:
//         Read a file and returns the content
// Parameters: 
// $1: File path (includes the file name and extension)
// ------------------------------------------------------------------------------
// Jaime Alvarez, 11/02/2015 (mm/dd/yyyy)

C_TEXT:C284($fileContent; $filePath; $1; $0; $buffer)
C_TIME:C306($vhDocRef)

$fileContent:=""
Case of 
	: (Count parameters:C259=0)
		$filePath:=""
	: (Count parameters:C259=1)
		$filePath:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// WARNING; THIS METHOD ONLY READ SMALL XML FILES 


If (Test path name:C476($filePath)=Is a document:K24:1)
	// Open and Read XML File
	$vhDocRef:=Open document:C264($filePath; Read mode:K24:5)
	If (OK=1)  // If the document was opened
		Repeat   // Loop until no more data
			RECEIVE PACKET:C104($vhDocRef; $buffer; 100)
			$fileContent:=$fileContent+$buffer
		Until (OK=0)
		CLOSE DOCUMENT:C267($vhDocRef)
	End if 
Else 
	myAlert("Cannot open: "+$filePath)
End if 

$0:=$fileContent




