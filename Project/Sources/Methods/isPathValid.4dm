//%attributes = {}
// isPathValid (filePath; document type): boolean
// returns true only if there is a document in that file path (doesn't work for folders)
// e.g. isPathValid ("C:\\"; is a volume)
// #util #filePath 

C_BOOLEAN:C305($0; $success)
C_TEXT:C284($1; $filePath)
C_LONGINT:C283($2; $pathType)
$pathType:=Is a document:K24:1

Case of 
	: (Count parameters:C259=0)
		$filePath:="C:\\"
		$pathType:=Is a folder:K24:2
		
	: (Count parameters:C259=1)
		$filePath:=$1
		
	: (Count parameters:C259=2)
		$filePath:=$1
		$pathType:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (Test path name:C476($filePath)=$pathType)
	$success:=True:C214
Else 
	$success:=False:C215
End if 

$0:=$success