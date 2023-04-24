//%attributes = {}
#DECLARE->$xmlRef : Text

var $xml : Text

$xml:=backup_getServerConfigFile


$xmlRef:=DOM Parse XML variable:C720($xml)
