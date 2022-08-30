//%attributes = {}
//author: Amir
//date: 13th Jan 2019
//this method is used for the form SR_CompletePLStatement (part A: trading income)
//it groups accounts by PL_Group and calulcates SUM([Registers]CreditLC) for each one
C_POINTER:C301($1; $arrPLGroupNames; $2; $arrTradingIncomesPtr)
C_DATE:C307($startDate; $3; $endDate; $4)
C_TEXT:C284($5; $branch)
ASSERT:C1129(Count parameters:C259=5; "Expected five parameters")
$arrPLGroupNames:=$1
$arrTradingIncomesPtr:=$2
$startDate:=$3
$endDate:=$4
$branch:=$5

READ ONLY:C145([Accounts:9])
READ ONLY:C145([Registers:10])
ALL RECORDS:C47([Accounts:9])
DISTINCT VALUES:C339([Accounts:9]PL_Group:40; $arrPLGroupNames->)

//sorting account PL groups
SORT ARRAY:C229($arrPLGroupNames->; <)
INSERT IN ARRAY:C227($arrTradingIncomesPtr->; 1; Size of array:C274($arrPLGroupNames->))
C_LONGINT:C283($i)
For ($i; 1; Size of array:C274($arrPLGroupNames->))
	QUERY:C277([Accounts:9]; [Accounts:9]PL_Group:40=($arrPLGroupNames->{$i}))
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
	$arrTradingIncomesPtr->{$i}:=Sum:C1([Registers:10]CreditLocal:24)
End for 
//for accounts that dont have any category
C_LONGINT:C283($emptyPLGroupIndex)
$emptyPLGroupIndex:=Find in array:C230($arrPLGroupNames->; "")
If ($emptyPLGroupIndex#-1)
	$arrPLGroupNames->{$emptyPLGroupIndex}:="Other Trades"
End if 

