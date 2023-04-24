READ ONLY:C145([Accounts:9])
READ ONLY:C145([Branches:70])

queryCashAccounts
allRecordsBranches(False:C215)
//QUERY([Branches];[Branches]isInactive=False)
orderByBranches
ORDER BY:C49([Accounts:9]; [Accounts:9]MainAccountID:2; >; [Accounts:9]AccountID:1; >)


C_LONGINT:C283($m; $n; $branchIterator)
$m:=Records in selection:C76([Accounts:9])
$n:=Records in selection:C76([Branches:70])

If ($m>0)
	//LISTBOX INSERT COLUMN(mainArrListBox;2;"Branch1";
	SELECTION TO ARRAY:C260([Accounts:9]AccountID:1; arrAccounts)
	SELECTION TO ARRAY:C260([Accounts:9]MainAccountID:2; arrMainAccounts)
	For ($branchIterator; 1; $n)  // iterate through the branches (vertically) ; for each branch iterate through the accounts (rows)
		
		C_TEXT:C284($branchName; $headerName; $branchID)
		GOTO SELECTED RECORD:C245([Branches:70]; $branchIterator)
		$branchID:=[Branches:70]BranchID:1
		$branchName:=[Branches:70]BranchName:2
		$headerName:="colH"+$branchID
		
		//$last:=LISTBOX Get number of columns(*;"mainArrListBox")+1
		C_POINTER:C301($arrPtr)
		$arrPtr:=Get pointer:C304("arrBranch"+String:C10($branchIterator))
		ARRAY TEXT:C222($arrPtr->; $m)
		ARRAY REAL:C219(arrSumBalances; $m)
		
		LISTBOX INSERT COLUMN:C829(*; "mainArrListBox"; $branchIterator+2; "col"+$branchID; $arrPtr->; $headerName; $headerName)
		//LISTBOX INSERT COLUMN ( {* ;} object ; colPosition ; colName ; colVariable ; headerName ; headerVar {; footerName ; footerVar} )  
		OBJECT SET TITLE:C194(*; $headerName; $branchID)
		
		C_LONGINT:C283($accountIterator)
		For ($accountIterator; 1; $m)  // fill the array with balances of the accounts
			C_TEXT:C284($accountID)
			C_REAL:C285($balance)
			$accountID:=arrAccounts{$accountIterator}  // iterate throught the account IDs
			$balance:=getAccountBalanceByBID($branchID; $accountID)
			arrSumBalances{$accountIterator}:=arrSumBalances{$accountIterator}+$balance
			$arrPtr->{$accountIterator}:=String:C10($balance; "###,###,###,###.##;(###,###,###,###.##);")
		End for 
		
	End for 
End if 
// $last:=LISTBOX Get number of columns(*;"mainArrListBox")+1
//LISTBOX INSERT COLUMN(*;"mainArrListBox";$n+3;"colSumBalances";arrSumBalances;"sumBalances";HeaderVar)
//OBJECT SET TITLE(*;"sumBalances";"Sum of Balances")
//OBJECT SET FORMAT(*;"
LISTBOX SET LOCKED COLUMNS:C1151(*; "mainArrListBox"; 2)
