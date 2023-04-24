//%attributes = {}

#DECLARE($headerNamesPtr : Pointer; $headerValuesPtr : Pointer)
var $token : Text

ARRAY TEXT:C222($headerNamesPtr->; 0)
ARRAY TEXT:C222($headerValuesPtr->; 0)

$token:="ty46l2ZSs3XcP9nNtlNFPwoDljJfmxJD"
$token:=getKeyValue("baserow.token"; $token)

APPEND TO ARRAY:C911($headerNamesPtr->; "Content-Type")
APPEND TO ARRAY:C911($headerValuesPtr->; "application/json")

APPEND TO ARRAY:C911($headerNamesPtr->; "Authorization")
APPEND TO ARRAY:C911($headerValuesPtr->; "Token "+$token)
