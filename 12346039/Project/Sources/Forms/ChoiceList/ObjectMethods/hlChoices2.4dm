// Object Method: aChoices

If (Form event code:C388=On Double Clicked:K2:5)  //& (aChoices#0))
	GET LIST ITEM:C378(Self:C308->; Selected list items:C379(Self:C308->); $itemRef; $itemText)
	aChoices:=$itemRef
	ACCEPT:C269
End if 