//%attributes = {}
//author: amir
//date: 15th Jan 2019
//description: calculates SUM([Registers]creditLocal) for any account type; for exmaple, revenue ([Accounts]AccountType=4)
//signature: calucalteIncomeByAccountType(
//->pointer to array to store names of accounts,
//->pointer to array to store SUM([Registers]creditLocal) 
//int for account type to query
//start date of period
//end date of period
//text for branch name
//)
C_POINTER:C301($1; $arrAccountNamesPtr)
C_POINTER:C301($2; $arrRevenuValuesPtr)
C_LONGINT:C283($3; $accountType)
C_DATE:C307($startDate; $4; $endDate; $5)
C_TEXT:C284($6; $branch)
ASSERT:C1129(Count parameters:C259=6; "Expected six parameters")

$arrAccountNamesPtr:=$1
$arrRevenuValuesPtr:=$2
$accountType:=$3
$startDate:=$4
$endDate:=$5
$branch:=$6

READ ONLY:C145([Accounts:9])
READ ONLY:C145([Registers:10])
ALL RECORDS:C47([Accounts:9])
QUERY:C277([Accounts:9]; [Accounts:9]Type:36=$accountType)
DISTINCT VALUES:C339([Accounts:9]AccountID:1; $arrAccountNamesPtr->)
SORT ARRAY:C229($arrAccountNamesPtr->; <)
INSERT IN ARRAY:C227($arrRevenuValuesPtr->; 1; Size of array:C274($arrAccountNamesPtr->))
C_LONGINT:C283($i)
For ($i; 1; Size of array:C274($arrAccountNamesPtr->))
	QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=$arrAccountNamesPtr->{$i})
	RELATE MANY SELECTION:C340([Registers:10]AccountID:6)
	QUERY SELECTION:C341([Registers:10]; [Registers:10]isCancelled:59=False:C215)
	If ($branch#"Branch")
		QUERY SELECTION:C341([Registers:10]; [Registers:10]BranchID:39=$branch; *)
		QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2>=$startDate; *)
		QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=$endDate)
	Else 
		QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2>=$startDate; *)
		QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=$endDate)
	End if 
	$arrRevenuValuesPtr->{$i}:=Sum:C1([Registers:10]CreditLocal:24)
End for 