//%attributes = {}
// apply4DTagsToDocument (filePath): text
// this method opens a file and applies 4DTags and returns the text


C_BLOB:C604($sourceBLOB; $destinationBLOB)
C_TEXT:C284($sourceText; $destinationFile)
C_TEXT:C284($sourceFile; $1)
C_TEXT:C284($destinationText; $0)


Case of 
	: (Count parameters:C259=0)
		C_TEXT:C284($dir)
		$dir:=Select folder:C670("")
		$sourceFile:=$dir+"source.txt"
		$destinationFile:=$dir+"generated.txt"
	: (Count parameters:C259=1)
		$sourceFile:=$1
		//$destinationFile:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684)
End case 
If (Test path name:C476($sourceFile)<0)
	myAlert($sourceFile+" is not a valid path")
Else 
	
	DOCUMENT TO BLOB:C525($sourceFile; $sourceBLOB)
	If (OK=1)
		$sourceText:=BLOB to text:C555($sourceBLOB; UTF8 text without length:K22:17)
		PROCESS 4D TAGS:C816($sourceText; $destinationText)
		$0:=$destinationText
		//TEXT TO BLOB($destinationText;$destinationBLOB;UTF8 text without length)
		//BLOB TO DOCUMENT($destinationFile;$destinationBLOB)
	Else   // handle error
		myAlert("error opening "+$sourceFile)
	End if 
	
End if 
