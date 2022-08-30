C_COLLECTION:C1488($source)
C_POINTER:C301($self)
$self:=Self:C308
C_LONGINT:C283($i; $len)
C_TEXT:C284($key)

applyFocusRect("focusRect")

$source:=New collection:C1472("Cash"; "Cheque"; "Account"; "Items"; "Wire"; "eWire")

If (Form event code:C388=On After Keystroke:K2:26)
	$key:=Keystroke:C390
	Case of 
		: ($key="C")
			$self->{0}:=$source[0]
		: (($key="h") | ($key="q") | ($key="k"))  // Cheque
			$self->{0}:=$source[1]
			
		: ($key="A")  // Account 
			$self->{0}:=$source[2]
		: ($key="I")  // Items
			$self->{0}:=$source[3]
		: ($key="W")  // Wire
			$self->{0}:=$source[4]
			
		: ($key="e")  // eWire
			$self->{0}:=$source[5]
	End case 
	POST KEY:C465(Tab:K15:37)
End if 

If (Form event code:C388=On After Edit:K2:43)
	// #ORDA
	C_TEXT:C284($str)
	$str:=Get edited text:C655
	$len:=Length:C16($str)
	$i:=$source.indexOf($str+"@")
	If ($i=-1)  // found; collections are zero
		$self->{0}:=$source[0]
		
	Else   // found in collection
		$self->{0}:=$source[$i]
		C_LONGINT:C283($len2)
		$len2:=Length:C16($source[$i])
		
		HIGHLIGHT TEXT:C210($self->; $len+1; $len2+1)
	End if 
	
End if 