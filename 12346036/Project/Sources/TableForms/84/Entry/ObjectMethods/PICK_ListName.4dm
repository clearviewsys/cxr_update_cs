
// ----------------------------------------------------
// User name (OS): Barclay
// Date and time: 06/14/18, 17:30:34
// ----------------------------------------------------
// Method: [CommonLists].Entry.PICK_ListName
// Description
// 
//
// Parameters
// ----------------------------------------------------


Case of 
	: (Form event code:C388=On Load:K2:1)
		Self:C308->:=Abs:C99(Find in array:C230(Self:C308->; [CommonLists:84]ListName:1))
		[CommonLists:84]ListName:1:=Self:C308->{Self:C308->}
		
		
	: (Form event code:C388=On Data Change:K2:15)
		[CommonLists:84]ListName:1:=Self:C308->{Self:C308->}
		
	Else 
		
		
End case 