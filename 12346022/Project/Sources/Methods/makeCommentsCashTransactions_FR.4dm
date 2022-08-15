//%attributes = {}
// makeCommentCashTransaction -> text

C_TEXT:C284($comments; $0; $theString)
$comments:="Montant de "+String:C10([CashTransactions:36]Amount:3; "|Currency")+" "+[CashTransactions:36]Currency:4  // Ex: Amount 1000 USD...

If ([CashTransactions:36]isPaid:2)  // payment is paid to customer
	$comments:=$comments+" payé comptant"
Else   // payment is received 
	$comments:=$comments+" reçue comptant"
End if 

RELATE MANY:C262([CashTransactions:36]CashTransactionID:1)
orderByCashInOuts
C_REAL:C285($qty; $sum; $product)
C_LONGINT:C283($n; $i)
$sum:=0

If (Records in selection:C76([CashInOuts:32])>0)
	FIRST RECORD:C50([CashInOuts:32])
	$comments:=$comments+" : "
	
	$n:=Records in selection:C76([CashInOuts:32])
	For ($i; 1; $n)
		$qty:=[CashInOuts:32]QtyIN:8+[CashInOuts:32]QtyOut:9
		If (($qty)>0)
			$theString:=CRLF+"("+String:C10($qty)+Char:C90(Tab:K15:37)+"x"+Char:C90(Tab:K15:37)+"["+String:C10([CashInOuts:32]Denomination:7)+"] = "
			$product:=roundToBase($qty*[CashInOuts:32]Denomination:7)
			$theString:=$theString+Char:C90(Tab:K15:37)+String:C10($product)+")"
			If ($i<$n)
				$theString:=$theString+" + "
			End if 
			$sum:=$sum+$product
			$comments:=$comments+$theString
		End if 
		NEXT RECORD:C51([CashInOuts:32])
	End for 
	$comments:=$comments+" = "+String:C10($sum)
End if 

$0:=$comments