//%attributes = {}
//author: Amir
//date: 5th March 2019
//calculates SUM([Registers]DebitLocal)-SUM([Registers]CreditLocal) 
//    for each [Account]AccountID,
//    for given [Account]Type, year and branch
//calculateAccountSummaryByType(
//arrAccountIdsPtr: a pointer to array text, to store account IDs in
//arrCalculatedValuesPtr: a pointer to array real, to store calculated values in
//startDate: start of period
//endDate: end of period
//branch: branch filter;
//accountType: the type of account to filter; for example 5 for Expense
//branchEmptyValue: which value for $branch means no filter should be done; for example "" or "Branch"
//)

C_POINTER:C301($arrAccountIDsPtr; $1)
C_POINTER:C301($arrCalculatedValuesPtr; $2)
C_DATE:C307($startDate; $3; $endDate; $4)
C_TEXT:C284($branch; $5)
C_LONGINT:C283($accountType; $6)
C_TEXT:C284($branchEmptyValue; $7)

ASSERT:C1129(Count parameters:C259=7; "Expected 7 parameters")

$arrAccountIDsPtr:=$1
$arrCalculatedValuesPtr:=$2
$startDate:=$3
$endDate:=$4
$branch:=$5
$accountType:=$6
$branchEmptyValue:=$7

READ ONLY:C145([Registers:10])
READ ONLY:C145([Accounts:9])

ARRAY TEXT:C222($arrAccountIds; 0)

QUERY:C277([Accounts:9]; [Accounts:9]Type:36=$accountType)
DISTINCT VALUES:C339([Accounts:9]AccountID:1; $arrAccountIds)
SORT ARRAY:C229($arrAccountIds; >)

RELATE MANY SELECTION:C340([Registers:10]AccountID:6)

QUERY SELECTION:C341([Registers:10]; [Registers:10]isCancelled:59=False:C215)
If ($branch#$branchEmptyValue)
	QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=$startDate; *)
	QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=$endDate; *)
	QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]BranchID:39=$branch)
Else 
	QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=$startDate; *)
	QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=$endDate)
End if 

CREATE SET:C116([Registers:10]; "validRegisters")

C_LONGINT:C283($loopIndex; $numRecords)
C_REAL:C285($calculated)
$numRecords:=Size of array:C274($arrAccountIds)

For ($loopIndex; 1; $numRecords)
	USE SET:C118("validRegisters")
	QUERY SELECTION:C341([Registers:10]; [Registers:10]AccountID:6=$arrAccountIds{$loopIndex})
	$calculated:=Sum:C1([Registers:10]DebitLocal:23)-Sum:C1([Registers:10]CreditLocal:24)
	APPEND TO ARRAY:C911($arrAccountIDsPtr->; $arrAccountIds{$loopIndex})
	APPEND TO ARRAY:C911($arrCalculatedValuesPtr->; $calculated)
End for 

CLEAR SET:C117("validRegisters")