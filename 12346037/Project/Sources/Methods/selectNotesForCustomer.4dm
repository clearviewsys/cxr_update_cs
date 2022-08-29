//%attributes = {}
// selectNotesForCustomer(customerID)

C_TEXT:C284($custID; $1)
C_LONGINT:C283($0)


$custID:=$1
SET QUERY DESTINATION:C396(Into current selection:K19:1)

QUERY:C277([CallLogs:51]; [CallLogs:51]CustomerID:2=$custID; *)
QUERY:C277([CallLogs:51];  & ; [CallLogs:51]doPopUp:8=True:C214)
$0:=Records in selection:C76([CallLogs:51])