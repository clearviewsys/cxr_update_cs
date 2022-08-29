//%attributes = {}
// getAllCheckLogByID ($id)
// Get all sanction List checklog using the ID

C_LONGINT:C283($1; $tableNum)
C_TEXT:C284($2; $id)

Case of 
		
	: (Count parameters:C259=2)
		$tableNum:=$1
		$id:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
READ ONLY:C145([SanctionCheckLog:111])  // added by TB Nov 2018
QUERY:C277([SanctionCheckLog:111]; [SanctionCheckLog:111]internalTableID:12=$tableNum; *)
QUERY:C277([SanctionCheckLog:111];  & ; [SanctionCheckLog:111]InternalRecordID:2=$id)
orderBySanctionCheckLog