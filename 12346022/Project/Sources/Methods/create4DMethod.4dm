//%attributes = {"shared":true,"publishedSoap":true,"publishedWsdl":true}
// create4DMethod (methodName;code;$folder)
C_TEXT:C284($1; $2; $3; $methodName; $methodCode; $folderName)
$methodName:=$1
$methodCode:=$2

C_LONGINT:C283($err)
ARRAY LONGINT:C221($attributes; 4)
C_BLOB:C604($code)

If (False:C215)  //not used right now
	TEXT TO BLOB:C554($methodCode; $code; Mac text without length:K22:10; *)
	$attributes{1}:=0  // 4D action?
	$attributes{2}:=0  // invisible?
	$attributes{3}:=0  // soap?
	$attributes{4}:=0  // published in wsdl?
End if 

If (Count parameters:C259=3)
	$folderName:=$3
Else 
	$folderName:="Default Folder"
End if 
myConfirm("Create method "+$methodName+CRLF+$methodCode; "Create"; "Skip")
If (OK=1)
	If (UTIL_isMethodExists($methodName)=False:C215)  // if method does not exits
		//$err:=UTIL_Method_CreateShared ($methodName;$attributes;$code;$folderName)
		UTIL_Method_CreateShared($methodName; $methodCode)
	Else 
		//ALERT($methodName+Char(13)+$methodCode)
	End if 
End if 