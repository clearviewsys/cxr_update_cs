//%attributes = {"shared":true}


C_TEXT:C284($tillNo)
C_TEXT:C284($formName)
C_BOOLEAN:C305($doPrintZero)
C_DATE:C307(vDate)
C_TIME:C306(vTime)
C_REAL:C285(vCashBalance)

vDate:=Current date:C33
vTime:=Current time:C178

$formName:="rep_MiniTillReport"
//$formName:="rep_XZreport"

$tillNo:=requestTillNo

CONFIRM:C162("Print accounts with zero balances?"; "Yes"; "No")
If (OK=1)
	$doPrintZero:=True:C214
End if 

CONFIRM:C162("Automatically print to thermal printer?"; "Yes"; "No")
If (OK=1)
	setPrintSettingsForReceipt
Else 
	PRINT SETTINGS:C106
End if 

If (OK=1)
	QUERY:C277([CashRegisters:33]; [CashRegisters:33]CashRegisterID:1=$tillNo)
	RELATE MANY SELECTION:C340([CashAccounts:34]CashRegisterID:2)  // select all the cash accounts related to the tills selected
	
	C_LONGINT:C283($n; $i)
	C_TEXT:C284($account)
	$n:=Records in selection:C76([CashAccounts:34])
	orderByCashAccounts
	
	If ($n>0)
		Print form:C5([Reports:73]; $formName; Form header:K43:3)
	End if 
	
	For ($i; 1; $n)  // loop through all cash account and print the balances of each
		GOTO SELECTED RECORD:C245([CashAccounts:34]; $i)
		RELATE ONE:C42([CashAccounts:34]AccountID:1)  // load the account (so that we can print the currency)
		$account:=[CashAccounts:34]AccountID:1
		vCashBalance:=getAccountBalance($account)
		If (($doPrintZero) | (vCashBalance#0))
			Print form:C5([Reports:73]; $formName; Form detail:K43:1)
		End if 
	End for 
	Print form:C5([Reports:73]; $formName; Form footer:K43:2)
	PAGE BREAK:C6
	
End if 