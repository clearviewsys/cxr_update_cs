C_TEXT:C284($thisCurrency)
C_PICTURE:C286(baseFlag)

$thisCurrency:=<>baseCurrency
Case of 
	: (Form event code:C388=On Load:K2:1)
		QUERY:C277([Flags:19]; [Flags:19]CurrencyCode:1=$thisCurrency)
		baseFlag:=[Flags:19]flag:4
	: (Form event code:C388=On Clicked:K2:4)
		vCurrency:=$thisCurrency
End case 
