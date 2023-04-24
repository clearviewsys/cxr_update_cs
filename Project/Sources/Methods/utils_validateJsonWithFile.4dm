//%attributes = {}
/* validate JSON using a file, also error trap 

#param $json  json object to validate
#param $folder  the folder to use if not RESOURCES/json-schemas"
#author: Wai-Kin Chau
*/
#DECLARE($jsonParam : Object; $pathParam : Text; $folderParam : 4D:C1709.Folder)->$result : Object
var $json : Object
var $folder : 4D:C1709.Folder
var $path : Text
var validateJsonError : Object
ARRAY TEXT:C222($textArray; 0)
ARRAY INTEGER:C220($inCompArray; 0)
ARRAY INTEGER:C220($codeArray; 0)
Case of 
	: (Count parameters:C259=0)
		GET LAST ERROR STACK:C1015($codeArray; $inCompArray; $textArray)
		validateJsonError:=New object:C1471(\
			"success"; False:C215; \
			"errors"; New collection:C1472(New object:C1471("message"; $textArray{1}))\
			)
		return 
	: (Count parameters:C259=2)
		$json:=$jsonParam
		$path:=$pathParam
		$folder:=Folder:C1567(Current resources folder:K5:16)
		$folder:=$folder.folder("json-schemas")
	: (Count parameters:C259=3)
		$json:=$jsonParam
		$path:=$pathParam
		$folder:=$folder
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($json=Null:C1517)
	return New object:C1471(\
		"success"; False:C215; \
		"errors"; New collection:C1472(New object:C1471("message"; "JSON is a null object."))\
		)
End if 
ON ERR CALL:C155("utils_validateJsonWithFile")
var $file : 4D:C1709.File
$file:=$folder.file($path)
var $schema : Object
var $raw : Text
$raw:=$file.getText()
If (validateJsonError=Null:C1517)
	$schema:=JSON Parse:C1218($raw)
End if 

var $result : Object
If (validateJsonError=Null:C1517)
	$result:=JSON Validate:C1456($json; $schema)
End if 

If (validateJsonError#Null:C1517)
	$result:=validateJsonError
End if 
CLEAR VARIABLE:C89(validateJsonError)
ON ERR CALL:C155("")