C_TEXT:C284(vFullComments; vWarning; vCurrency)
C_REAL:C285(vAmount; vFromBalanceAfter; vToBalanceAfter)
C_DATE:C307(vFromDate; vToDate)

If (Form event code:C388=On Load:K2:1)
	vTransferDate:=Current date:C33
	//initialize other vars
	vAmount:=0
	vFromBalanceAfter:=0
	vToBalanceAfter:=0
	vFromBalance:=0
	vtoBalance:=0
	vFromAccount:=""
	vToAccount:=""
	vComments:=""
	vWarning:=""
	vCurrency:=<>baseCurrency
	vFromDate:=vInvoiceDate
	vToDate:=vInvoiceDate
	
	//SET ENTERABLE(bValidate;False)
End if 

If ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Outside Call:K2:11))
	vFromBalance:=getAccountBalance(vFromAccount)
	
	vToBalance:=getAccountBalance(vToAccount)
End if 

vFromBalanceAfter:=vFromBalance-vAmount
vToBalanceAfter:=vToBalance+vAmount

vFullComments:="Transfer "+String:C10(vAmount)+" "+vFromCurrency+" from "+vFromAccount+" to account "+vToAccount
vFullComments:=vFullComments+"."+vComments