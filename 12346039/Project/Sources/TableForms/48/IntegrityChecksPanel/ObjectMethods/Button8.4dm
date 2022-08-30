
ARRAY TEXT:C222($recordArray; 0)

QUERY:C277([IC_FailedRecords:49]; [IC_FailedRecords:49]tableNo:2=Table:C252(->[Invoices:5]))

SELECTION TO ARRAY:C260([IC_FailedRecords:49]recordID:3; $recordArray)
QUERY WITH ARRAY:C644([RegistersAuditTrail:88]orig_InvoiceNumber:12; $recordArray)
QUERY SELECTION:C341([RegistersAuditTrail:88]; [RegistersAuditTrail:88]ActionTrigger:47="DEL")

If (Records in selection:C76([RegistersAuditTrail:88])>0)
	CREATE SET:C116([RegistersAuditTrail:88]; getTableNamedSet(->[RegistersAuditTrail:88]))
	displayLBox_RegistersAuditTrail
Else 
	myAlert("No [RegistersAuditTrail] to display.")
End if 

ALL RECORDS:C47([IC_FailedRecords:49])