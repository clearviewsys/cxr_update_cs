//%attributes = {}
// integrityChecksCreate($tIntegrityCheckID; $tRecordID;$iTableNum; $tDesciption)

var $tIntegrityCheckID; $tRecordID; $tDesciption; $1; $2; $4 : Text
var $iTableNum; $3 : Integer
var $ICFailedRecords; $IntegrityChecks : Object

$tIntegrityCheckID:=$1
$tRecordID:=$2
$iTableNum:=$3
$tDesciption:=$4

$ICFailedRecords:=ds:C1482.IC_FailedRecords.new()
$ICFailedRecords.IntegrityCheckID:=$tIntegrityCheckID
$ICFailedRecords.recordID:=$tRecordID
$ICFailedRecords.tableNo:=$iTableNum
$ICFailedRecords.save()

$IntegrityChecks:=ds:C1482.IntegrityChecks.query("IntegrityCheckID =:1"; "IC_"+$tIntegrityCheckID)
If ($IntegrityChecks=Null:C1517)
	$IntegrityChecks:=ds:C1482.IntegrityChecks.new()
	$IntegrityChecks.IntegrityCheckID:="IC_"+$tIntegrityCheckID
	$IntegrityChecks.Description:=$tDesciption
	$IntegrityChecks.save()
End if 
