//%attributes = {}


C_TEXT:C284($0)
C_BLOB:C604($1; $decryptThis)
C_OBJECT:C1216($2; $pattern)
C_LONGINT:C283($i; $offset)
C_LONGINT:C283($longVar; $type)
C_REAL:C285($realVar)
C_TEXT:C284($textVar)
C_DATE:C307($datevar)
C_BLOB:C604($blobVar)

$decryptThis:=$1  //EXPAND BLOB($1)

If (Count parameters:C259>1)
	$pattern:=$2
Else 
	$pattern:=New object:C1471
	$pattern.text1:="placeholder"
	$pattern.date1:=Add to date:C393(!00-00-00!; 2011; 11; 22)
	$pattern.long1:=(Random:C100%(32000-1200+1))+1200
	$pattern.encryptThis:="placeholder"
	$pattern.real1:=1/33
	$pattern.text2:="placeholder"
End if 

$offset:=0

ARRAY TEXT:C222($properties; 0)

OB GET PROPERTY NAMES:C1232($pattern; $properties)

For ($i; 1; Size of array:C274($properties))
	
	
	If ($properties{$i}#"encryptThis")
		
		$type:=Value type:C1509($pattern[$properties{$i}])
		
		Case of 
				
			: ($type=Is date:K8:7)
				
				$datevar:=$pattern[$properties{$i}]
				BLOB TO VARIABLE:C533($decryptThis; $datevar; $offset)
				
				
			: ($type=Is text:K8:3)
				
				$textVar:=$pattern[$properties{$i}]
				BLOB TO VARIABLE:C533($decryptThis; $textVar; $offset)
				
				
			: ($type=Is longint:K8:6)
				
				$longVar:=$pattern[$properties{$i}]
				BLOB TO VARIABLE:C533($decryptThis; $longVar; $offset)
				
				
			: ($type=Is real:K8:4)
				
				$realVar:=$pattern[$properties{$i}]
				BLOB TO VARIABLE:C533($decryptThis; $realVar; $offset)
				
				
			: ($type=Is BLOB:K8:12)
				
				$blobVar:=$pattern[$properties{$i}]
				BLOB TO VARIABLE:C533($decryptThis; $blobVar; $offset)
				
				
		End case 
		
	Else 
		
		BLOB TO VARIABLE:C533($decryptThis; $0; $offset)
		
	End if 
	
End for 
