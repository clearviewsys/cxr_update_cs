If ([Registers:10]InternalRecordID:18#"")
	//QUERY(Table([Registers]externalTableNumber)->;Field([Registers]externalTableNumber;1)->=[Registers]externalReference)  ` look for the related 
	queryByID(Table:C252([Registers:10]InternalTableNumber:17); [Registers:10]InternalRecordID:18)
	displayCurrentRecord(Table:C252([Registers:10]InternalTableNumber:17))
End if 