
If (Form event code:C388=On After Keystroke:K2:26)
	If ([Items:39]isBarCoded:23)
		C_TEXT:C284($text)
		$text:=Get edited text:C655
		[Items:39]barCodeLength:24:=Length:C16($text)
		REDRAW:C174([Items:39]barCodeLength:24)
	End if 
End if 

If (Form event code:C388=On Data Change:K2:15)
	[Items:39]barCodeLength:24:=Length:C16([Items:39]ItemCode:27)
End if 