//%attributes = {"shared":true,"publishedWeb":true}

C_TEXT:C284($0; $html)

C_OBJECT:C1216($registers; $register)

$html:=""

$registers:=ds:C1482.Registers.query("InvoiceNumber == :1"; [Invoices:5]InvoiceID:1)

If ($registers.length>0)
	
	$html:=$html+"<table class='table table-condensed table-striped table-responsive'>"
	
	$html:=$html+"<thead>"
	$html:=$html+"<tr>"
	$html:=$html+"<th>Account</th>"
	$html:=$html+"<th align=right>Buy</th>"
	$html:=$html+"<th align=right>Sell</th>"
	$html:=$html+"<th>CCY</th>"
	$html:=$html+"<th align=right>Rate</th>"
	$html:=$html+"<th align=right>Fees</th>"
	$html:=$html+"<th>Comments</th>"
	$html:=$html+"</tr>"
	$html:=$html+"</thead>"
	$html:=$html+"<tbody>"
	
	For each ($register; $registers)
		$html:=$html+"<tr>"
		$html:=$html+"<td>"+$register.AccountID+"</td>"
		$html:=$html+"<td align=right>"+String:C10($register.DebitLocal; "###,###,##0.00")+"</td>"
		$html:=$html+"<td align=right>"+String:C10($register.CreditLocal; "###,###,##0.00")+"</td>"
		$html:=$html+"<td>"+$register.Currency+"</td>"
		$html:=$html+"<td align=right>"+String:C10($register.OurRate; "##0.0000")+"</td>"
		$html:=$html+"<td align=right>"+String:C10($register.totalFees; "###,###,##0.00")+"</td>"
		$html:=$html+"<td>"+$register.Comments+"</td>"
		$html:=$html+"</tr>"
		
	End for each 
	
	$html:=$html+"</tbody>"
	$html:=$html+"</table>"
	
End if 


$0:=Char:C90(1)+$html