//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay
// Date and time: 06/13/18, 15:04:21
// ----------------------------------------------------
// Method: UTIL_getPrimaryKeys
// Description
// 
//
// Parameters
// ----------------------------------------------------


ARRAY POINTER:C280($aptrFields; 0)
ARRAY TEXT:C222($atUndefined; 0)
C_REAL:C285($i)
C_TEXT:C284($tResult)

For ($i; 1; Get last table number:C254)
	If (Is table number valid:C999($i))
		APPEND TO ARRAY:C911($aptrFields; UTIL_getPrimaryKey(Table:C252($i)))
		
		If (Is nil pointer:C315($aptrFields{Size of array:C274($aptrFields)}))
			APPEND TO ARRAY:C911($atUndefined; Table name:C256($i))
		End if 
	End if 
	
End for 

$tResult:=""

For ($i; 1; Size of array:C274($aptrFields))
	If (Not:C34(Is nil pointer:C315($aptrFields{$i})))
		$tResult:=$tResult+Table name:C256($aptrFields{$i})+": "+Field name:C257($aptrFields{$i})+Char:C90(Carriage return:K15:38)
	End if 
End for 

For ($i; 1; Size of array:C274($atUndefined))
	$tResult:=$tResult+$atUndefined{$i}+": NO PK DEFINED"+Char:C90(Carriage return:K15:38)
End for 

SET TEXT TO PASTEBOARD:C523($tResult)