
ARRAY TEXT:C222($recordArray; 0)

QUERY:C277([IC_FailedRecords:49]; [IC_FailedRecords:49]tableNo:2=Table:C252(->[Invoices:5]))

SELECTION TO ARRAY:C260([IC_FailedRecords:49]recordID:3; $recordArray)
QUERY WITH ARRAY:C644([Invoices:5]InvoiceID:1; $recordArray)

If (Records in selection:C76([Invoices:5])>0)
	
	SELECTION TO ARRAY:C260([Invoices:5]InvoiceID:1; $recordArray)
	QUERY WITH ARRAY:C644([Registers:10]InvoiceNumber:10; $recordArray)
	
	CREATE SET:C116([Registers:10]; getTableNamedSet(->[Registers:10]))
	displayLBox_Registers
Else 
	myAlert("No [Register] to display.")
End if 

ALL RECORDS:C47([IC_FailedRecords:49])