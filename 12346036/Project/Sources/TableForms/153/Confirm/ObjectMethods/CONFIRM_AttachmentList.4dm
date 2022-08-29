
C_LONGINT:C283($iPos; $iRef)
C_TEXT:C284($tText; $tValue)


Case of 
	: (Form event code:C388=On Double Clicked:K2:5)
		
		$iPos:=Selected list items:C379(Self:C308->)
		If ($iPos>0)
			GET LIST ITEM:C378(Self:C308->; $iPos; $iRef; $tText)
			
			GET LIST ITEM PARAMETER:C985(Self:C308->; $iRef; "link"; $tValue)
			
			iH_onClickLink($tText; $tValue)
			
		End if 
		
		
	Else 
		
End case 