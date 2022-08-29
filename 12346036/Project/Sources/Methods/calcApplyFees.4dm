//%attributes = {}
// calcApplyFee( amountLocal; percentFee;flatFeeLocal)-> amountLocal minus the fees

C_REAL:C285($1; $2; $3; $0)
C_BOOLEAN:C305($isReceived; $4)
$isReceived:=$4

If ($isReceived)
	$0:=($1*(1-($2/100)))-$3
Else 
	$0:=($1*(1+($2/100)))+$3
End if 