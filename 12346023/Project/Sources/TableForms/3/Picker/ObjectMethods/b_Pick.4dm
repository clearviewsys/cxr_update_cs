//If (Form event=On Clicked)
//USE ENTITY SELECTION(Form.selectedCustomers)  // map the selection to the customer table
//displaySelectedRecords (->[Customers])
//End if 
If (Form:C1466.pickerList.selectedEntities=Null:C1517)
	REJECT:C38
Else 
	ACCEPT:C269
End if 