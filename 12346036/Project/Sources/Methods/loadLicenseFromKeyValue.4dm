//%attributes = {}
//loadLicenseFromKeyValue
//purpose: Update/Create a license record with data from a given KeyValue record
//inputs: KeyValue Key (string)

C_TEXT:C284($1; $key)

C_TEXT:C284($value)

Case of 
	: (Count parameters:C259=1)
		$key:=$1
End case 

$value:=getKeyValue($key)
setLicenseValue($key; $value)
