handlePICKSearchVariable(Self:C308; Current form table:C627; ->[Items:39]ItemID:1; ->[Items:39]ItemName:2; ->[Items:39]ItemName:2; ->[Items:39]ItemID:1; ->[Items:39]ItemCode:27)
//handlePICKSearchVariable (Self;Current form table;->[Products]UID;->[Products]productName;->[Products]productName;->[Products]UID;->[Products]ProductCode)

C_LONGINT:C283($length)
$length:=Length:C16(Get edited text:C655)

If ((Form event code:C388=On After Keystroke:K2:26) & ($length>6))  // barcodes should be at least 6 characters
	If (Records in selection:C76([Items:39])=1)
		FIRST RECORD:C50([Items:39])
		LOAD RECORD:C52([Items:39])
		If ([Items:39]isBarCoded:23 & ($length=[Items:39]barCodeLength:24))
			handlePickItemButton
		End if 
	End if 
	//handlePickFormSearchField
End if 