//%attributes = {"shared":true}
C_POINTER:C301($1)  // Jan 16, 2012 19:21:44 -- I.Barclay Berry 
//C_LONGINT($winRef)
//$winRef:=Open form window([Forms];"TransferFunds";Plain window )
//DIALOG([Forms];"TransferFunds")
openFormWindow(->[Invoices:5]; "TransferFunds")
CLOSE WINDOW:C154
