
C_LONGINT:C283($i)

Case of 
	: (Form event code:C388=On Load:K2:1)
		//C_STRING(14;RPT_iTables)
		C_LONGINT:C283(RPT_iTables)
		
		RPT_iTables:=New list:C375
		
		For ($i; 1; Get last table number:C254)
			If (Is table number valid:C999($i))
				APPEND TO LIST:C376(RPT_iTables; Table name:C256($i); $i)
			End if 
		End for 
		
		SORT LIST:C391(RPT_iTables)
		
		If ([Reports:73]TableNo:8>0)
			SELECT LIST ITEMS BY REFERENCE:C630(RPT_iTables; [Reports:73]TableNo:8)
		Else 
			SELECT LIST ITEMS BY REFERENCE:C630(RPT_iTables; 1)
			[Reports:73]TableNo:8:=1
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		[Reports:73]TableNo:8:=Selected list items:C379(RPT_iTables; *)
		
	: (Form event code:C388=On Unload:K2:2)
		CLEAR LIST:C377(RPT_iTables)
	Else 
		
End case 