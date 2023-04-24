HandleEntryFormMethod

If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222(vDefaultPrinterName; 0)
	PRINTERS LIST:C789(vDefaultPrinterName)
	RELATE ONE:C42([ClientPrefs:26]BranchID:32)
	GOTO OBJECT:C206([ClientPrefs:26]ComputerAlias:33)
End if 

If (doComplyWithSkatteverket)
	[ClientPrefs:26]doPrintInvoiceAfterSave:13:=True:C214
End if 
HandleEntryForm

If (Form event code:C388=On Clicked:K2:4)
	RELATE ONE:C42([ClientPrefs:26]BranchID:32)
End if 
