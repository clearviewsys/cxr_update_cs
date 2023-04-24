//%attributes = {}
QUERY:C277([eWires:13]; [eWires:13]isPaymentSent:20=True:C214; *)  // sent
QUERY:C277([eWires:13];  & ; [eWires:13]isSettled:23=False:C215; *)  // pending
QUERY:C277([eWires:13];  & ; [eWires:13]isCancelled:34=False:C215)  // and not cancelled