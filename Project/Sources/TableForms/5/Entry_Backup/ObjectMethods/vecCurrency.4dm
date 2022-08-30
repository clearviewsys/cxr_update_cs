C_BOOLEAN:C305($dataChanged)
C_LONGINT:C283($formEvent; $foundIndex)
C_TEXT:C284($key; $searchKey)

$formEvent:=Form event code:C388

//If ($formEvent=On After Keystroke )
//$key:=Keystroke
//$searchKey:=Get edited text
//$foundIndex:=Find in array(vecCurrency;$searchKey+"@")
//If ($foundIndex>0)
//vecCurrency{0}:=vecCurrency{$foundIndex}
//Else 
//vecCurrency{0}:=""
//End if 
//HIGHLIGHT TEXT(vecCurrency;1;1)
//End if 

//handleFocusBorder ("focus_vVecCurrency")
applyFocusRect

If (($formEvent=On Clicked:K2:4) | ($formEvent=On Data Change:K2:15))
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
	
End if 


If ($formEvent#On Load:K2:1)
	C_TEXT:C284($vCurrency)
	If ($dataChanged)
		handleVecCurrencyMethod
	End if 
End if 


