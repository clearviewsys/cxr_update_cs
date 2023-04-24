//%attributes = {}
//C_TEXT($path;$json;$appVersion)
//C_OBJECT($0)

//$appVersion:=Application version

//If (Num($appVersion)>=1800)
//$path:=Get 4D folder(Current resources folder)+"mainformtemplate.json"
//Else 
//$path:=Get 4D folder(Current resources folder)+"mainformtemplatev17.json"
//End if 

//$formJSON:=Document to text($path;"UTF-8")

//$0:=JSON Parse($formJSON)
