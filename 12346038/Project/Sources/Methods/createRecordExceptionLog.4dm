//%attributes = {}

// createRecordExceptionLog (->[TABLE]; Type; systemRef; desc)

C_POINTER:C301($tablePtr; $1)
C_TEXT:C284($exceptionType; $2)
C_TEXT:C284($externalRef; $3)
C_TEXT:C284($description; $4)

$tablePtr:=$1
$exceptionType:=$2
$externalRef:=$3
$description:=$4

READ WRITE:C146([ExceptionsLog:75])
CREATE RECORD:C68([ExceptionsLog:75])

[ExceptionsLog:75]ExceptionLogID:1:=makeExceptionLogID
[ExceptionsLog:75]BranchID:12:=getBranchID
[ExceptionsLog:75]Date:2:=Current date:C33
[ExceptionsLog:75]Time:3:=Current time:C178
[ExceptionsLog:75]UserID:5:=getApplicationUser

[ExceptionsLog:75]TableNo:6:=Table:C252($tablePtr)

[ExceptionsLog:75]ExceptionType:4:=$exceptionType
[ExceptionsLog:75]Description:8:=$description
[ExceptionsLog:75]ExternalRef:7:=$externalRef

SAVE RECORD:C53([ExceptionsLog:75])
UNLOAD RECORD:C212([ExceptionsLog:75])
READ ONLY:C145([ExceptionsLog:75])
