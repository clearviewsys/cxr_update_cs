handleWebEwiresInvoiceBtn

//Case of 
//: (Form event=On Load)
//If ([WebEWires]status=20)
//Case of 
//: ([WebEWires]paymentInfo.invoiceID=Null)
//OBJECT SET VISIBLE(Self->;True)
//OBJECT SET VISIBLE(*;"invoiceNumber@";False)
//: ([WebEWires]paymentInfo.invoiceID="")
//OBJECT SET VISIBLE(Self->;True)
//OBJECT SET VISIBLE(*;"invoiceNumber@";False)
//Else 
//OBJECT SET VISIBLE(Self->;False)
//OBJECT SET VISIBLE(*;"invoiceNumber@";True)
//End case 
//Else 
//OBJECT SET VISIBLE(Self->;False)
//OBJECT SET VISIBLE(*;"invoiceNumber@";True)
//End if 

//Else 
//setNextCustomer ([WebEWires]CustomerID)
//newRecordInvoices 
//initNextCustomer 
//End case 