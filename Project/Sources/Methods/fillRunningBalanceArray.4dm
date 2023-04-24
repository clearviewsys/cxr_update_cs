//%attributes = {}
// fillRunningBalanceArray(->debitArr;->creditArr;->runningBalanceArray;opening;->validationChecks)
// PRE: these arrays must be the same size

C_POINTER:C301($1; $2; $3)
C_REAL:C285($openingBalance; $4)
C_LONGINT:C283($n; $i)

C_POINTER:C301($arrDebitPtr; $arrCreditPtr; $arrBalancePtr)
$arrDebitPtr:=$1
$arrCreditPtr:=$2
$arrBalancePtr:=$3
Case of 
	: (Count parameters:C259=4)
		$openingBalance:=$4
	Else 
		$openingBalance:=0
End case 

$n:=Size of array:C274($arrDebitPtr->)
If ($n>0)
	$arrBalancePtr->{0}:=$openingBalance
	For ($i; 1; $n)
		$arrBalancePtr->{$i}:=$arrBalancePtr->{$i-1}+$arrDebitPtr->{$i}-$arrCreditPtr->{$i}
	End for 
End if 
