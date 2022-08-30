RELATE ONE SELECTION:C349([Cheques:1]; [Customers:3])  // first select all customers related to cheques
handleSortButtonTable(->[Customers:3]; ->[Customers:3]FullName:40; ->[Cheques:1]ChequeID:1)  // sort the customers
RELATE MANY SELECTION:C340([Cheques:1]CustomerID:2)  // finally, reselect all cheques according to the new sort order
