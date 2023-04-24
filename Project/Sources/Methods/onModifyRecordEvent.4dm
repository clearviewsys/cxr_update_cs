//%attributes = {}
// onModifyRecordEvent

// this will return true if a record is being modified on load

C_BOOLEAN:C305($0)

$0:=((Form event code:C388=On Load:K2:1) & (Record number:C243(Current form table:C627->)>=0))
