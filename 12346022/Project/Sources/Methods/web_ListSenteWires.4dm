//%attributes = {"publishedWeb":true}
// eWiresList

C_TEXT:C284(webTitle)
C_TEXT:C284(webBody)


QUERY:C277([eWires:13]; [eWires:13]isSettled:23=False:C215; *)
QUERY:C277([eWires:13];  & ; [eWires:13]isPaymentSent:20=False:C215; *)
QUERY:C277([eWires:13];  & ; [eWires:13]isCancelled:34=False:C215)

web_ListSelectedeWires