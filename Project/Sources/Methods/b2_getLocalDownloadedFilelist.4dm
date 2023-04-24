//%attributes = {"executedOnServer":true}
C_COLLECTION:C1488($0; $local)
C_TEXT:C284($1; $downloadPath)
C_OBJECT:C1216($file)
C_LONGINT:C283($i)

If (Count parameters:C259=0)
	
	$downloadPath:=b2_getLocalDownloadDestination
	
Else 
	
	$downloadPath:=$1
	
End if 

$local:=New collection:C1472

If (Test path name:C476($downloadPath)=Is a folder:K24:2)
	
	ARRAY TEXT:C222($files; 0)
	
	DOCUMENT LIST:C474($downloadPath; $files)
	
	For ($i; 1; Size of array:C274($files))
		
		// $file:=Path to object($downloadPath+$files{$i})
		$file:=File:C1566($downloadPath+$files{$i}; fk platform path:K87:2)
		
		If (Not:C34($file.isFolder))
			If (($file.extension=".4BK") | ($file.extension=".4BL"))
				If ($local=Null:C1517)
					$local:=New collection:C1472
				End if 
				$local.push($file)
			End if 
		End if 
		
	End for 
	
	$0:=$local
	
End if 

