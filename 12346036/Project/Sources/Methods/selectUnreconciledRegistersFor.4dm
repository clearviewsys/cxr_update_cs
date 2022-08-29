//%attributes = {}

// selectUnreconciledRegistersFor (accountID;fromDate;toDate)

C_TEXT:C284($1; $accountID)
C_DATE:C307($2; $3; $fromDate; $toDate)
C_BOOLEAN:C305($4; $doIncludeNRFromBefore)

$accountID:=$1
$fromDate:=$2
$toDate:=$3

// select the unreconciled registers for the account first
QUERY:C277([Registers:10]; [Registers:10]AccountID:6=$accountID; *)
QUERY:C277([Registers:10];  & [Registers:10]RegisterDate:2<$fromDate; *)
QUERY:C277([Registers:10];  & ; [Registers:10]isValidated:35=False:C215)
CREATE SET:C116([Registers:10]; "$unreconciled")

// select the registers of the account in the data range
QUERY:C277([Registers:10]; [Registers:10]AccountID:6=$accountID; *)
QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2>=$fromDate; *)
QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2<=$toDate)
CREATE SET:C116([Registers:10]; "$dateRanged")

UNION:C120("$unreconciled"; "$dateRanged"; "$resulting")
USE SET:C118("$resulting")


