//%attributes = {}
// queryRegistersByID(registerID)

C_TEXT:C284($registerID; $1)
$registerID:=$1

READ ONLY:C145([Registers:10])
SET QUERY DESTINATION:C396(Into current selection:K19:1)
QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=$registerID)
