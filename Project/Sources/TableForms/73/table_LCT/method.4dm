C_LONGINT:C283(cbIncludeDebit)
C_LONGINT:C283(cbIncludeCredit)

C_REAL:C285(vLowerRangeUSD)
C_DATE:C307(vFromDate; vToDate)

If (Form event code:C388=On Load:K2:1)
	vLowerRangeUSD:=100000
	cbIncludeDebt:=0
	cbIncludeCredit:=1
	ARRAY BOOLEAN:C223(reg_RegistersListBox; 0)
	
End if 