If (Form event code:C388=On Load:K2:1)
	
End if 

If (Form event code:C388=On Clicked:K2:4)
	C_LONGINT:C283(VProgressBar; $i; $n)
	$i:=getTotalEODTellerproof
	$n:=Size of array:C274(cbCurrencies)
	vProgressBar:=Int:C8($i/$n*100)
	
	If (VProgressBar>=100)
		OBJECT SET VISIBLE:C603(*; "Save@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "CheckMark"; True:C214)
	End if 
	
	
End if 

vSumTotals:=Sum:C1(arrTotals)

