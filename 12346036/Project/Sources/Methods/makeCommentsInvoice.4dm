//%attributes = {}
C_TEXT:C284($0)
If ([Invoices:5]isTransfer:42)
	$0:=[Customers:3]FullName:40+" transferred "+String:C10([Invoices:5]fromAmount:25; "|Currency")+" "+[Invoices:5]fromCurrency:3+" on "+String:C10([Invoices:5]CreationDate:13; "|DateDisplay")
	
Else 
	$0:=[Customers:3]FullName:40+" exchanged "+String:C10([Invoices:5]fromAmount:25; "|Currency")+" "+[Invoices:5]fromCurrency:3+" to "+String:C10([Invoices:5]toAmount:26; "|Currency")+" "+[Invoices:5]toCurrency:8+" on "+String:C10([Invoices:5]CreationDate:13; "|DateDisplay")
	
End if 

