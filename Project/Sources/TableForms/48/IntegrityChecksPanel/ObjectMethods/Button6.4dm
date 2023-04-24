
ARRAY TEXT:C222($recordArray; 0)

QUERY:C277([IC_FailedRecords:49]; [IC_FailedRecords:49]tableNo:2=Table:C252(->[Invoices:5]))

SELECTION TO ARRAY:C260([IC_FailedRecords:49]recordID:3; $recordArray)
QUERY WITH ARRAY:C644([Invoices:5]InvoiceID:1; $recordArray)

If (Records in selection:C76([Invoices:5])>0)
	CREATE SET:C116([Invoices:5]; getTableNamedSet(->[Invoices:5]))
	displayLBox_Invoices
Else 
	myAlert("No [Invoices] to display.")
End if 

ALL RECORDS:C47([IC_FailedRecords:49])