//%attributes = {}
// makeCommentCashTransaction -> text

C_TEXT:C284($comments; $0)
If ([ItemInOuts:40]isSold:7)  // payment is paid to customer
	$comments:="Sold "
Else   // payment is received 
	$comments:="Purchased "
End if 

If ([ItemInOuts:40]Qty:8=1)
	$comments:=$comments+String:C10([ItemInOuts:40]Qty:8)+" "+[Items:39]Unit:6
Else 
	$comments:=$comments+String:C10([ItemInOuts:40]Qty:8)+" "+[Items:39]Unit:6+"s"
End if 
appendToStringOnCondition(([Items:39]ItemName:2#""); ->$comments; " "+[Items:39]ItemName:2; False:C215)
appendToStringOnCondition(([Items:39]Description:19#""); ->$comments; "("+[Items:39]Description:19+")"; False:C215)

If ([ItemInOuts:40]Qty:8=1)
	$comments:=$comments+" for "+String:C10([ItemInOuts:40]AmountBeforeTax:10)+" "+<>baseCurrency
Else 
	$comments:=$comments+" for "+String:C10([ItemInOuts:40]UnitPrice:9)+" "+<>baseCurrency+" per "+[Items:39]Unit:6+". Price before tax "+String:C10([ItemInOuts:40]AmountBeforeTax:10)+" "+<>baseCurrency
End if 

If ([ItemInOuts:40]Amount:22#[ItemInOuts:40]AmountBeforeTax:10)  //taxes paid
	$comments:=$comments+". Tax: "+String:C10([ItemInOuts:40]Amount:22-[ItemInOuts:40]AmountBeforeTax:10)+" "+<>baseCurrency
End if 

$0:=$comments+"."