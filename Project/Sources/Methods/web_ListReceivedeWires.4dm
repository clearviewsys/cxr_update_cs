//%attributes = {"publishedWeb":true}
// eWiresList




QUERY:C277([eWires:13]; [eWires:13]isSettled:23=False:C215; *)  // still upaid 
QUERY:C277([eWires:13];  & ; [eWires:13]isPaymentSent:20=True:C214; *)  // received (for channel)
QUERY:C277([eWires:13];  & ; [eWires:13]isCancelled:34=False:C215)
web_ListSelectedeWires