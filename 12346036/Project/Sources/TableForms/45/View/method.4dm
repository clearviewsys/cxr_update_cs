If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11))
	RELATE MANY:C262([ItemCategories:45]ItemCategory:1)  // load all items in this category
End if 