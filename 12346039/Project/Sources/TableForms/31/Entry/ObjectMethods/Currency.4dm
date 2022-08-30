ARRAY REAL:C219(arrDenominations; 0)
pickCurrencyISOCode(Self:C308)
Self:C308->:=[Flags:19]CurrencyCode:1

If (Form event code:C388=On Data Change:K2:15)
	vLastCodeUsed:=Self:C308->
	handleFillDenominationsArray
End if 