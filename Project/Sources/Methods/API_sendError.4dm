//%attributes = {}


C_TEXT:C284($1; $httpCode)
C_OBJECT:C1216($2; $json)

If (Count parameters:C259>=1)
	$httpCode:=$1
Else 
	$httpCode:="400"
End if 

If (Count parameters:C259>=2)
	$json:=$2
Else 
	$json:=New object:C1471
End if 


ARRAY TEXT:C222($aNames; 0)
ARRAY TEXT:C222($aValues; 0)

APPEND TO ARRAY:C911($aNames; "X-VERSION")
APPEND TO ARRAY:C911($aValues; "1.1")
APPEND TO ARRAY:C911($aNames; "X-STATUS")
APPEND TO ARRAY:C911($aValues; $httpCode)

WEB SET HTTP HEADER:C660($aNames; $aValues)
WEB SEND TEXT:C677(JSON Stringify:C1217($json))
