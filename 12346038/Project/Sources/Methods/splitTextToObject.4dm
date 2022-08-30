//%attributes = {}
//splitTextToObject($aString;$filedSplit;$lineSplit)
//
// split a string into an object
//
// Parameters:
// $aString (C_TEXT)
//   text to split
// $fieldSplit (C_TEXT)
//   the separator between field and the value
// $lineSplit (C_TEXT)
//   the separator between each property
//
// Return: (C_OBJECT)
//   the resulting object

// Unit test is written @Wai-Kin

C_TEXT:C284($1; $aString)
C_TEXT:C284($2; $fieldSplit)
C_TEXT:C284($3; $lineSplit)
C_OBJECT:C1216($0; $map)

Case of 
	: (Count parameters:C259=3)
		$aString:=$1
		$fieldSplit:=$2
		$lineSplit:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_REAL:C285($start)
$start:=1
$map:=New object:C1471
While (($start#0) & ($start<Length:C16($aString)))
	C_REAL:C285($end)
	
	C_TEXT:C284($field)
	$end:=Position:C15($fieldSplit; $aString; $start)
	$field:=Substring:C12($aString; $start; $end-$start)
	
	$start:=$end+Length:C16($fieldSplit)
	
	C_TEXT:C284($value)
	$end:=Position:C15($lineSplit; $aString; $start)
	If ($end#0)
		$value:=Substring:C12($aString; $start; $end-$start)
		
		$start:=$end+Length:C16($lineSplit)
	Else 
		$value:=Substring:C12($aString; $start)
		$start:=$end
	End if 
	OB SET:C1220($map; $field; $value)
End while 

$0:=$map