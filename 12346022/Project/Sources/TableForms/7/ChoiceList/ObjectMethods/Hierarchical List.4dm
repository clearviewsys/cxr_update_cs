

If (Form event code:C388=On Double Clicked:K2:5) | (Form event code:C388=On Clicked:K2:4)
	
	//GET LIST ITEM(Self->;Selected list item(Self->);$itemRef;$itemText)
	
	//aChoices:=$itemRef
	
	//ACCEPT
	
	
	C_LONGINT:C283($iStyle; $iPict)
	C_BOOLEAN:C305($bEnterable)
	
	C_LONGINT:C283($iCheckPict; $iBlankPict)
	$iCheckPict:=131072+26292
	$iBlankPict:=131072+13616
	
	GET LIST ITEM PROPERTIES:C631(hlChoices; Selected list items:C379(hlChoices); $bEnterable; $iStyle; $iPict)
	
	If ($iPict=0) | ($iPict=$iBlankPict)
		SET LIST ITEM PROPERTIES:C386(hlChoices; Selected list items:C379(hlChoices); $bEnterable; $iStyle; $iCheckPict)
	Else 
		SET LIST ITEM PROPERTIES:C386(hlChoices; Selected list items:C379(hlChoices); $bEnterable; $iStyle; $iBlankPict)
	End if 
	
	//_O_REDRAW LIST(hlChoices)
	
End if 