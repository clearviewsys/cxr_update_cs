//%attributes = {}


C_TEXT:C284($1)
C_TEXT:C284($0; $code)

C_OBJECT:C1216($api)


$code:=""

If (Count parameters:C259>=1)
	$api:=JSON Parse:C1218($1)
Else 
	$api:=JSON Parse:C1218(Get text from pasteboard:C524)
End if 


// create boiler plate 4D code 
// do i jsut create the method???






$0:=$code