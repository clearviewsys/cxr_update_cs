If (Form event code:C388=On Row Moved:K2:32)
	// renumber rows
	C_LONGINT:C283($i; $n)
	$n:=Size of array:C274(ARRRULENO)
	For ($i; 1; $n)
		ARRRULENO{$i}:=$i
	End for 
End if 
