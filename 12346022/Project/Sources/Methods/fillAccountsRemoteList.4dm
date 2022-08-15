//%attributes = {}
C_TEXT:C284($1; $branchID; $webURL)

Case of 
	: (Count parameters:C259=1)
		$branchID:=$1
		$webURL:=getBranch4DWebServerURL($branchID)
		
	: (Count parameters:C259=2)
		$branchID:=$1
		$webURL:=$2
	Else 
		$branchID:="BB"
		$webURL:="lnbb.dynns.com"
End case 

$n:=Records in selection:C76([Accounts:9])
ARRAY REAL:C219(arrBalance; $n)
ARRAY REAL:C219(arrBalance1; $n)
ARRAY REAL:C219(arrBalance2; $n)

C_TEXT:C284($accountID; $webURL)

SELECTION TO ARRAY:C260([Accounts:9]AccountID:1; arrAccounts)

C_LONGINT:C283($progress)
C_LONGINT:C283($i; $n)

$progress:=launchProgressBar("Accessing Remote Location...")
$i:=1

If ($webURL="")
	myAlert("The URL for accessing the remote site is blank")
End if 

If ($i>0)
	Repeat 
		$accountID:=arrAccounts{$i}
		arrBalance1{$i}:=Round:C94(getAccountBalanceByBID($branchID; $accountID); 2)
		If ($webURL="")
			arrBalance2{$i}:=0  // problem 
		Else 
			arrBalance2{$i}:=Round:C94(ws_getAccountBalance($accountID; $webURL); 2)
		End if 
		arrBalance{$i}:=arrBalance1{$i}-arrBalance2{$i}
		refreshProgressBar($progress; $i; $n)
		setProgressBarTitle($progress; $accountID+" "+String:C10(arrBalance2{$i}))
		
		$i:=$i+1
	Until (($i>$n) | (isProgressBarStopped($progress)))
End if 
HIDE PROCESS:C324($progress)

