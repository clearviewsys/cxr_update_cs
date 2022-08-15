
ARRAY TEXT:C222($recordArray; 0)

QUERY:C277([IC_FailedRecords:49]; [IC_FailedRecords:49]tableNo:2=Table:C252(->[Registers:10]))

SELECTION TO ARRAY:C260([IC_FailedRecords:49]recordID:3; $recordArray)
QUERY WITH ARRAY:C644([Registers:10]RegisterID:1; $recordArray)

If (Records in selection:C76([Registers:10])>0)
	CREATE SET:C116([Registers:10]; getTableNamedSet(->[Registers:10]))
	displayLBox_Registers
Else 
	myAlert("No registers to display.")
End if 

ALL RECORDS:C47([IC_FailedRecords:49])