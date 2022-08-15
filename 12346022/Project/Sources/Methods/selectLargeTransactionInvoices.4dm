//%attributes = {}
//QUERY([Invoices];[Invoices]TotalBoughtAmountCAD>=◊declarationFormLimit;*)
QUERY:C277([Invoices:5]; [Invoices:5]fromAmountLC:38>=<>declarationFormLimit; *)
QUERY:C277([Invoices:5];  | ; [Invoices:5]toAmountLC:39>=<>declarationformLimit)
QUERY SELECTION:C341([Invoices:5]; [Invoices:5]CustomerID:2#getSelfCustomerID)