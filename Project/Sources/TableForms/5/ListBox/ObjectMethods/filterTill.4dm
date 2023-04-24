handleTillsDD(Self:C308)

/*
If (Form event code=On Load)
ARRAY TEXT(arrTills; 0)
ALL RECORDS([CashRegisters])
SELECTION TO ARRAY([CashRegisters]CashRegisterID; arrTills)
INSERT IN ARRAY(arrTills; 1)
arrTills{1}:="Tills"
arrTills:=1

End if 

If (Form event code=On Clicked)
C_TEXT($till)
$till:=arrTills{arrTills}
selectRegistersByTillNo($till)

// map the registers to the insvoice
RELATE MANY SELECTION([Registers]InvoiceNumber)
End if 

*/