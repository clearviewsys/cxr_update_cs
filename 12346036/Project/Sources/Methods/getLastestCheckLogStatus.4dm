//%attributes = {}
// getLastestCheckLogStatus ($tableNumber; $internalRecordId; ->$iconPtr; $name)
// Gets the latest getLastestCheckLogStatus from the SanctionList Check Log

C_LONGINT:C283($1; $tableNumber)
C_TEXT:C284($2; $internalRecordId)
C_POINTER:C301($3; $iconPtr)
C_TEXT:C284($4; $name)

C_TEXT:C284($sql)
C_LONGINT:C283($checkResult; $numRecs)

Case of 
		
	: (Count parameters:C259=4)
		$tableNumber:=$1
		$internalRecordId:=$2
		$iconPtr:=$3
		$name:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


//SET QUERY DESTINATION(Into set;"SCL")
READ ONLY:C145([SanctionCheckLog:111])

QUERY:C277([SanctionCheckLog:111]; [SanctionCheckLog:111]internalTableID:12=$tableNumber; *)
QUERY:C277([SanctionCheckLog:111];  & ; [SanctionCheckLog:111]InternalRecordID:2=$internalRecordId)
//QUERY([SanctionCheckLog]; & ;[SanctionCheckLog]FullName=$name)

$numRecs:=Records in selection:C76([SanctionCheckLog:111])

ORDER BY:C49([SanctionCheckLog:111]; [SanctionCheckLog:111]CheckDate:3; <; [SanctionCheckLog:111]CheckResult:10; >)  // <: DESC ORDER else ASC

FIRST RECORD:C50([SanctionCheckLog:111])
$checkResult:=[SanctionCheckLog:111]CheckResult:10



clearPictureField($iconPtr)

If ($numRecs>0)
	sl_setSanctionListCheckIcon($checkResult; $iconPtr)
End if 













