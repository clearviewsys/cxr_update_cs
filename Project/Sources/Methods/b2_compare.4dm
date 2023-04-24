//%attributes = {}
// compares content of local backup destination folder and bucket content

#DECLARE->$result : Object

var $remote; $remotenames; $local; $notinremote; $notinlocal; $localnames : Collection

$remote:=b2_ls
$remotenames:=$remote.extract("fileName")


$local:=b2_getLocalFileList


If ($local#Null:C1517)
	
	If ($local.length>0)
		
		$localnames:=$local.extract("name")
		
		$notinremote:=col_Difference($localnames; $remotenames)
		
		$notinlocal:=col_Difference($remotenames; $localnames)
		
		$result:=New object:C1471
		$result.toUpload:=$notinremote
		$result.toDownload:=$notinlocal
		
	End if 
	
End if 
