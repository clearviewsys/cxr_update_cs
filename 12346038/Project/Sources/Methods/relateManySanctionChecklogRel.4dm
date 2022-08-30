//%attributes = {}
// relateManySanctionChecklogRel
C_POINTER:C301($1; $tablePtr)
C_TEXT:C284($2; $internalRecordId)


Case of 
		
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$internalRecordId:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
READ ONLY:C145([SanctionCheckLog:111])
QUERY:C277([SanctionCheckLog:111]; [SanctionCheckLog:111]internalTableID:12=Table:C252($tablePtr); *)
QUERY:C277([SanctionCheckLog:111];  & ; [SanctionCheckLog:111]InternalRecordID:2=$internalRecordId)

orderBySanctionCheckLog