//%attributes = {}
ARRAY TEXT:C222($numbersArray; 0)
ARRAY TEXT:C222($namesArray; 0)
C_BOOLEAN:C305($exists)
C_LONGINT:C283($i)

$exists:=False:C215

PLUGIN LIST:C847($numbersArray; $namesArray)

For ($i; 0; Size of array:C274($namesArray))
	If ($namesArray{$i}="4D_Pack")
		$exists:=True:C214
	End if 
End for 

$0:=$exists
