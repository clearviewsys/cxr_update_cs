//%attributes = {}
// select all the ewires received that are not cancelled 
// or select ewires that are not assigned to a particular link yet

C_TEXT:C284(theCustomerID)
QUERY:C277([eWires:13]; [eWires:13]CustomerID:15=theCustomerID)
QUERY SELECTION:C341([eWires:13]; [eWires:13]toCountryCode:112=<>COUNTRYCODE; *)  // it must be received and
QUERY SELECTION:C341([eWires:13];  & ; [eWires:13]isCancelled:34=False:C215; *)  // not cancelled
QUERY SELECTION:C341([eWires:13];  & ; [eWires:13]isSettled:23=False:C215)  // and not paid
orderByeWires
// ASSERT: ewires are received and not CANCELLED

//QUERY SELECTION([eWires];[eWires]CustomerID=theCustomerID;*)
//QUERY SELECTION([eWires]; | ;[eWires]CustomerID="")
//
//