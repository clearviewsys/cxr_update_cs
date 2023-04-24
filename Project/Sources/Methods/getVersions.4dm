//%attributes = {}
#DECLARE->$versions : Object

var $path; $json : Text

// $path:="/RESOURCES/version.json"

$path:=Get 4D folder:C485(Current resources folder:K5:16)+"version.json"

If (Test path name:C476($path)=Is a document:K24:1)
	
	$json:=Document to text:C1236($path; "UTF-8")
	
	$versions:=JSON Parse:C1218($json)
	
End if 
