//%attributes = {}
// AU_Get7ZipPath
// Return the path of th 7Zip executable path

C_TEXT:C284($0; $sevenZipPath)

$sevenZipPath:="C:\\Program Files (x86)\\7-Zip\\7z.exe"

If (Test path name:C476($sevenZipPath)=Is a document:K24:1)
	// Continue
Else 
	// Check if a 64bit version is installed
	$sevenZipPath:="C:\\Program Files\\7-Zip\\7z.exe"
	If (Test path name:C476($sevenZipPath)=Is a document:K24:1)
		// Continue
	Else 
		$sevenZipPath:=""
	End if 
	
End if 

$0:=$sevenZipPath
