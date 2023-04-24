//%attributes = {}

// makeCommentCashTransaction -> text

// Modified by: Tiran Behrouz (5/29/13)


C_TEXT:C284($comments; $0; $theString; $customer)

If ([CashTransactions:36]CustomerID:10=getSelfCustomerID)
	$customer:="company "
Else 
	If ([Customers:3]isCompany:41)
		
		Case of 
			: ([Customers:3]isMSB:85)
				$customer:="corporate customer "
			: ([Customers:3]isWholesaler:87)
				$customer:="supplier "
			Else 
				$customer:="company "
		End case 
		
	Else 
		$customer:="customer "
	End if 
End if 

If ([CashTransactions:36]Currency:4=<>baseCurrency)
	$theString:=String:C10([CashTransactions:36]Amount:3; "|Currency")+" "+[Currencies:6]Name:2  // Ex: Amount 1000 USD...
	
	If ([CashTransactions:36]isPaid:2)  // payment is paid to customer
		$comments:="Paid to "+$customer+$theString+" in cash."
	Else   // payment is received 
		$comments:="Received from "+$customer+$theString+" in cash."
	End if 
	
Else 
	$theString:=String:C10([CashTransactions:36]Amount:3; "|Currency")+" "+[Currencies:6]Country:22+" "+[Currencies:6]Name:2  // Ex: Amount 1000 USD...
	
	If ([CashTransactions:36]isPaid:2)  // payment is paid to customer
		$comments:="Sold to "+$customer+$theString+" in cash."
	Else   // payment is received 
		$comments:="Bought from "+$customer+$theString+" in cash."
	End if 
	
End if 



$theString:=""

RELATE MANY:C262([CashTransactions:36]CashTransactionID:1)
orderByCashInOuts
C_REAL:C285($qty; $sum; $product)
C_LONGINT:C283($n; $i)
$sum:=0

If (Records in selection:C76([CashInOuts:32])>0)
	FIRST RECORD:C50([CashInOuts:32])
	$comments:=$comments+" in denominations of : "
	
	$n:=Records in selection:C76([CashInOuts:32])
	For ($i; 1; $n)
		$qty:=[CashInOuts:32]QtyIN:8-[CashInOuts:32]QtyOut:9
		
		// Modified by: Tiran Behrouz (5/29/13)
		//If (($qty)>0)
		
		$theString:=CRLF+"("+String:C10($qty)+Char:C90(Tab:K15:37)+"x"+Char:C90(Tab:K15:37)+"["+String:C10([CashInOuts:32]Denomination:7)+"] = "
		$product:=roundToBase($qty*[CashInOuts:32]Denomination:7)
		$theString:=$theString+Char:C90(Tab:K15:37)+String:C10($product)+")"
		If ($i<$n)
			$theString:=$theString+" + "
		End if 
		$sum:=$sum+$product
		$comments:=$comments+$theString
		
		//End if 
		
		NEXT RECORD:C51([CashInOuts:32])
	End for 
	$comments:=$comments+" = "+String:C10($sum)
End if 

$0:=$comments