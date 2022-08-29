C_COLLECTION:C1488($source)
C_POINTER:C301($self)
C_TEXT:C284($key; $str)

$self:=Self:C308
C_LONGINT:C283($i; $len)

If (Form event code:C388=On After Keystroke:K2:26)
	$key:=Keystroke:C390
	Case of 
		: ($key=Char:C90(Backspace:K15:36))
			$self->:=""
			
	End case 
End if 

If (Form event code:C388=On After Edit:K2:43)
	$source:=New collection:C1472("Cash"; "Cheque"; "Account"; "Wire"; "eWire"; "Items")
	// #ORDA
	$str:=Get edited text:C655
	$len:=Length:C16($str)
	$i:=$source.indexOf($str+"@")
	If ($i=-1)  // found; collections are zero
	Else   // found in collection
		$self->:=$source[$i]
		C_LONGINT:C283($len2)
		$len2:=Length:C16($source[$i])
		
		HIGHLIGHT TEXT:C210($self->; $len+1; $len2+1)
	End if 
	
End if 