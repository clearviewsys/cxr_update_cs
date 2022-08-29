//%attributes = {}
// CreateSignature
READ WRITE:C146([Signatures:141])
CREATE RECORD:C68([Signatures:141])

[Signatures:141]InvoiceNumber:2:=vInvoiceNumber
[Signatures:141]Signature:3:=Signature
[Signatures:141]CreationDate:4:=Current date:C33(*)
SAVE RECORD:C53([Signatures:141])

UNLOAD RECORD:C212([Signatures:141])

// Signature has been saved
//myAlert (GetLocalizedErrorMessage (4234))

