HandleEntryForm
If (Form event code:C388=On Load:K2:1)
	//starttransaction  // disabled by: Barclay Berry (2/24/13) per Tiran
	ALL RECORDS:C47([TableLimitations:55])
	READ WRITE:C146([TableLimitations:55])
	fillArrayTableNamesAndNumbers(->arrTableNumbers; ->arrTableNames)
End if 

