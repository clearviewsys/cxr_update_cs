
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
		
		
	: (Form event code:C388=On Data Change:K2:15)
		[AuditControls:117]fieldNum:4:=Selected list items:C379(Self:C308->; *)
		
	Else 
		
		
End case 