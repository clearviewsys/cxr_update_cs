//%attributes = {}
C_TEXT:C284($folderpath; $0)
$folderpath:=getFolderPathByFileID("XMLFOLDERPATH")
If ($folderpath="")
	$0:=<>XMLFOLDERPATH
Else 
	$0:=$folderpath
End if 

