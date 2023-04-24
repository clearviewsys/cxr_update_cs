C_LONGINT:C283($n)
If (Form event code:C388=On Data Change:K2:15)
	$n:=Length:C16(Self:C308->)
	If (Substring:C12(Self:C308->; $n; 1)="/")
		Self:C308->:=Substring:C12(Self:C308->; 1; $n-1)
	End if 
End if 
