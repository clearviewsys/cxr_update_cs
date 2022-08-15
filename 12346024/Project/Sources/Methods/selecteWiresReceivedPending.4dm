//%attributes = {}
// select all the ewires received that are not cancelled 
// or select ewires that are not assigned to a particular link yet

QUERY:C277([eWires:13]; [eWires:13]toCountry:10=<>CompanyCountry; *)  // it must be received and (intended for our country)
QUERY:C277([eWires:13];  & ; [eWires:13]isCancelled:34=False:C215; *)  // not cancelled
QUERY:C277([eWires:13];  & ; [eWires:13]isSettled:23=False:C215)  // and not paid

// ASSERT: ewires are received and not CANCELLED

//QUERY SELECTION([eWires];[eWires]CustomerID=theCustomerID;*)
//QUERY SELECTION([eWires]; | ;[eWires]CustomerID="")
//
//