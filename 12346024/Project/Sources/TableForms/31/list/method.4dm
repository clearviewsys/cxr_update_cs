handleListForm
C_LONGINT:C283($R; $G; $B; $RGB)

If (Form event code:C388=On Display Detail:K2:22)
	QUERY:C277([Currencies:6]; [Currencies:6]ISO4217:31=[Denominations:31]Currency:2)
	
	//$R:=Ascii(Substring([Currencies]ISO4217;1;1))
	//$G:=Ascii(Substring([Currencies]ISO4217;2;1))
	//$B:=Ascii(Substring([Currencies]ISO4217;3;1))
	//$RGB:=($R*256*256)+($G*256)+$B
	//SET RGB COLORS(*;"backdrop";127;$RGB)
End if 