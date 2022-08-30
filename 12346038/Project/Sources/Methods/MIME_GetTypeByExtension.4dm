//%attributes = {}
C_TEXT:C284($0; $1; $FileExtension)
C_COLLECTION:C1488($MimeTypes; $FoundExtension)

ASSERT:C1129(Count parameters:C259#0)

$FileExtension:=$1
$0:="application/octet-stream"  // default MIME type

$MimeTypes:=MIME_GetMappingCollection

$FoundExtension:=$MimeTypes.query("ext = :1"; $FileExtension)

If ($FoundExtension#Null:C1517)
	
	If ($FoundExtension.length>0)
		
		$0:=$FoundExtension[0].mimetype
		
	End if 
	
End if 
