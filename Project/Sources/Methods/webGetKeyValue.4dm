//%attributes = {"shared":true,"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 11/20/19, 21:55:40
// ----------------------------------------------------
// Method: webGetKeyValue
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $tKey)
C_TEXT:C284($2; $default)

C_TEXT:C284($0)

C_TEXT:C284($value)


$tKey:=strRemoveSpaces($1)

If (Substring:C12($tKey; 1; 1)="/")
	$tKey:=Substring:C12($tKey; 2; Length:C16($tKey))
End if 

If (Count parameters:C259>=2)
	$default:=$2
Else 
	$default:="<Please configure the key: "+$tKey+">"
End if 

$value:=keyValue_getValue($tKey; $default)

If ($value="<ignore>")
	$0:=""
Else 
	//$0:=Char(1)+Split string($value; "'").join("\\'"; ck ignore null or empty)
	$0:=Split string:C1554($value; "'").join("\\'"; ck ignore null or empty:K85:5)
End if 