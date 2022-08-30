//%attributes = {}
// onNewRecordEvent

// this will return true if a new record is being created an load


C_BOOLEAN:C305($0)

$0:=((Form event code:C388=On Load:K2:1) & (Is new record:C668(Current form table:C627->)))

