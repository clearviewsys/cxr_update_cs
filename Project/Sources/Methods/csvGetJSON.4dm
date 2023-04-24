//%attributes = {}
#DECLARE($jsonFile : Text)->$result : Collection

var $json : Text

If (Test path name:C476($jsonFile)=Is a document:K24:1)
	
	$json:=Document to text:C1236($jsonFile; "UTF-8")
	
	$result:=New collection:C1472
	
	$result:=JSON Parse:C1218($json)
	
	
End if 
