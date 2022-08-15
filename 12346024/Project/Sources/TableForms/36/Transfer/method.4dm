C_REAL:C285(vTotal; vDenomination)
C_LONGINT:C283(vQty)
C_TEXT:C284(vComments)

If (Form event code:C388=On Load:K2:1)  // both for modification and new record
	vQty:=0
	vDenomination:=0
	vCurrency:=""
	vFromCashAccount:=""
	vToCashAccount:=""
	vDate:=Current date:C33
	ARRAY LONGINT:C221(arrQty; 0)
	ARRAY REAL:C219(arrDenomination; 0)
	ARRAY REAL:C219(arrTotal; 0)
End if 

vTotalAmount:=Sum:C1(arrTotal)
//vTotal:=vQty*vDenomination

handleCloseBox
