//%attributes = {}
//@milan 3/12/22 
// partial implementation of v18 and v19 like function File

C_OBJECT:C1216($0; $file)
C_TEXT:C284($1; $path)
C_BOOLEAN:C305($invisible; $locked)
C_DATE:C307($createdon; $modifiedon)
C_TIME:C306($createdat; $modifiedat)

$path:=$1

$file:=Path to object:C1547($path)

$file.platformPath:=$path
$file.path:=Convert path system to POSIX:C1106($path)
$file.fullName:=$file.name+"."+$file.extension
$file.isFile:=Not:C34($file.isFolder)

If ($file.isFile)
	
	If (Test path name:C476($path)=Is a document:K24:1)
		
		$file.exists:=True:C214
		
		GET DOCUMENT PROPERTIES:C477($path; $locked; $invisible; $createdon; $createdat; $modifiedon; $modifiedat)
		
		$file.creationDate:=$createdon
		$file.creationTime:=$createdat
		$file.modificationDate:=$modifiedon
		$file.modificationTime:=$modifiedat
		
		$file.hidden:=$invisible
		$file.size:=Get document size:C479($path)
		
	End if 
	
Else 
	
	If (Test path name:C476($path)=Is a folder:K24:2)
		
		$file.exists:=True:C214
		
	End if 
	
End if 

$0:=$file
