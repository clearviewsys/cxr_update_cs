
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


C_POINTER:C301($ptrVar)
C_LONGINT:C283($iTable)

Case of 
	: (Form event code:C388=On Load:K2:1)
		$ptrVar:=OBJECT Get pointer:C1124(Object named:K67:5; "PREFS_TableList")
		$ptrVar->:=New list:C375
		UTIL_tables2List($ptrVar->)
		SELECT LIST ITEMS BY REFERENCE:C630($ptrVar->; 1)
		
		
		
	: (Form event code:C388=On Data Change:K2:15)
		
		//$iTable:=Selected list items(Self->;*)
		
	Else 
		
		
End case 