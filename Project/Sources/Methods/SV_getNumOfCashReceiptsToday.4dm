//%attributes = {}
// SV_getNumberOfCashReceiptsToday 

C_LONGINT:C283($0; $count)

SET QUERY DESTINATION:C396(Into variable:K19:4; $count)
QUERY:C277([ControlBoxLog:68]; [ControlBoxLog:68]Date:2=Current date:C33; *)
QUERY:C277([ControlBoxLog:68];  & ; [ControlBoxLog:68]isSuccessful:9=True:C214)  // only successful attempts are important


SET QUERY DESTINATION:C396(Into current selection:K19:1)
$0:=$count