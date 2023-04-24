If (Form event code:C388=On Data Change:K2:15)
	var $ccy : Text
	pickCurrency(->$ccy)
	If (OK=1)
		Form:C1466.filterCCY:=$ccy
	Else 
		Form:C1466.filterCCY:=""
	End if 
End if 