//%attributes = {"executedOnServer":true}
// EOS property set

C_COLLECTION:C1488($0; $local)
C_TEXT:C284($destinationFolder)
C_LONGINT:C283($i)
C_OBJECT:C1216($file)

ARRAY TEXT:C222($files; 0)

$destinationFolder:=backup_getDestinationFolder

If (Test path name:C476($destinationFolder)=Is a folder:K24:2)
	
	DOCUMENT LIST:C474($destinationFolder; $files)
	
	$local:=New collection:C1472
	
	For ($i; 1; Size of array:C274($files))
		
		// $file:=Path to object($destinationFolder+$files{$i})
		$file:=File:C1566($destinationFolder+$files{$i}; fk platform path:K87:2)
		
		If (Not:C34($file.isFolder))
			If (($file.extension=".4BK") | ($file.extension=".4BL"))
				$local.push($file)
			End if 
		End if 
		
	End for 
	
	$0:=$local
	
End if 
