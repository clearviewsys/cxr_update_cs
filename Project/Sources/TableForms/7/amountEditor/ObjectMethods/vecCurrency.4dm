C_BOOLEAN:C305($dataChanged)
If (vecCurrency{0}#vCurrency)  // data changed
	$dataChanged:=True:C214
Else 
	$dataChanged:=False:C215
End if 

vCurrency:=Self:C308->{0}
If (vCurrency="")
	vCurrency:=<>baseCurrency
End if 
pickCurrency(->vCurrency)
setVecCurrency(vCurrency; $dataChanged)


C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388

If ($formEvent#On Load:K2:1)
	C_TEXT:C284($vCurrency)
	If ($dataChanged)
		handleVecCurrencyMethod
	End if 
End if 
