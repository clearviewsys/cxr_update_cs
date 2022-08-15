//%attributes = {}

C_TEXT:C284(vInvoiceNumber; vFromCurrency)
C_REAL:C285(vRemainReceive; vRemainPaid)
C_DATE:C307(vInvoiceDate)

If (Form event code:C388=On Load:K2:1)
	vInvoiceNumber:="0"
	vInvoiceDate:=Current date:C33
	vFromCurrency:=""
	vRemainPaid:=0
	vRemainReceive:=0
End if 