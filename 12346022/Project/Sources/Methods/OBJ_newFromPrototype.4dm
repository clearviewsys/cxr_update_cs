//%attributes = {}



C_POINTER:C301($1; $ptrNewObject)
C_TEXT:C284($2; $tPrototype)
//C_POINTER($2;$ptrPrototype)
C_OBJECT:C1216($objPrototype)
C_LONGINT:C283($i)


$ptrNewObject:=$1  //pointer to object to add keys
$tPrototype:=$2

$objPrototype:=OB Get:C1224(<>objectPrototypes; $tPrototype)

If (OB Is defined:C1231($objPrototype))
	OB GET PROPERTY NAMES:C1232($objPrototype; $atKeys)
	
	For ($i; 1; Size of array:C274($atKeys))
		If (OB Is defined:C1231($ptrNewObject->; $atKeys{$i}))  //all good 
		Else   //need to define
			If (True:C214)
				OB SET:C1220($ptrNewObject->; $atKeys{$i}; "")
			Else 
				OB SET NULL:C1233($ptrNewObject->; $atKeys{$i})
			End if 
		End if 
	End for 
End if 