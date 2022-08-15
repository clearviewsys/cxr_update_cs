//%attributes = {}
// selectActiveMessagesFromCustomer (customerID)
// this method will select all messages that have not been replied to for customer

C_TEXT:C284($custID; $1)
C_LONGINT:C283($0)


$custID:=$1
SET QUERY DESTINATION:C396(Into current selection:K19:1)

QUERY:C277([MESSAGES:11]; [MESSAGES:11]FromUserID:5=$custID; *)
QUERY:C277([MESSAGES:11];  & ; [MESSAGES:11]isActionTaken:11=False:C215)
$0:=Records in selection:C76([MESSAGES:11])