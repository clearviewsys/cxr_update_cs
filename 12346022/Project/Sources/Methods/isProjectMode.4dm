//%attributes = {}
// returns True if database in in project mode

C_BOOLEAN:C305($0)
C_LONGINT:C283($result)

$result:=Get database parameter:C643(Is current database a project:K37:98)

$0:=($result=1)
