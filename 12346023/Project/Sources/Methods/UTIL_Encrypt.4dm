//%attributes = {}

// ----------------------------------------------------
// User name (OS): madamov
// Date and time: 22/07/20, 22:44:35
// ----------------------------------------------------
// Method: UTIL_Encrypt
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_BLOB:C604($0)  // return value
C_TEXT:C284($1; $encryptThis)
C_OBJECT:C1216($2; $pattern)
C_LONGINT:C283($i)
C_LONGINT:C283($longVar)
C_REAL:C285($realVar)
C_TEXT:C284($textVar)
C_DATE:C307($datevar)
C_BLOB:C604($blobVar)
C_LONGINT:C283($type)

$encryptThis:=$1

If (Count parameters:C259>1)
	$pattern:=$2
Else 
	$pattern:=New object:C1471
	$pattern.text1:=STR_getRandomString(100; 500)
	$pattern.date1:=Add to date:C393(!00-00-00!; 2011; 11; 22)
	$pattern.long1:=(Random:C100%(32000-1200+1))+1200
	$pattern.encryptThis:="placeholder"
	$pattern.real1:=$pattern.long1/33
	$pattern.text2:=STR_getRandomString(50; 249)
End if 

ARRAY TEXT:C222($properties; 0)

OB GET PROPERTY NAMES:C1232($pattern; $properties)

For ($i; 1; Size of array:C274($properties))
	
	
	If ($properties{$i}#"encryptThis")
		
		$type:=Value type:C1509($pattern[$properties{$i}])
		
		Case of 
				
			: ($type=Is date:K8:7)
				
				$datevar:=$pattern[$properties{$i}]
				VARIABLE TO BLOB:C532($datevar; $0; *)
				
				
			: ($type=Is text:K8:3)
				
				$textVar:=$pattern[$properties{$i}]
				VARIABLE TO BLOB:C532($textVar; $0; *)
				
				
			: ($type=Is longint:K8:6)
				
				$longVar:=$pattern[$properties{$i}]
				VARIABLE TO BLOB:C532($longVar; $0; *)
				
				
			: ($type=Is real:K8:4)
				
				$realVar:=$pattern[$properties{$i}]
				VARIABLE TO BLOB:C532($realVar; $0; *)
				
				
			: ($type=Is BLOB:K8:12)
				
				$blobVar:=$pattern[$properties{$i}]
				VARIABLE TO BLOB:C532($blobVar; $0; *)
				
				
		End case 
		
	Else 
		
		VARIABLE TO BLOB:C532($encryptThis; $0; *)
		
	End if 
	
End for 

//COMPRESS BLOB($0;Fast compression mode)
