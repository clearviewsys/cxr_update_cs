//%attributes = {}
Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY BOOLEAN:C223(flagListBox; 0)
		QUERY:C277([Currencies:6]; [Currencies:6]isOnInvoice:50=True:C214)
		ORDER BY:C49([Currencies:6]; [Currencies:6]displayOrderOnBoard:6; >; [Currencies:6]CurrencyCode:1; >)
		SELECTION TO ARRAY:C260([Currencies:6]CurrencyCode:1; arrCurr; [Currencies:6]Flag:3; arrFlag)
		INSERT IN ARRAY:C227(arrCurr; 1)
		INSERT IN ARRAY:C227(arrFlag; 1)
		arrCurr{1}:=<>BASECURRENCY
		QUERY:C277([Flags:19]; [Flags:19]CurrencyCode:1=<>BASECURRENCY)
		arrFlag{1}:=[Flags:19]flag:4
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($row)
		$row:=listbox_getFirstSelectedRow(->flagListBox)
		If ($row<=Size of array:C274(arrCurr))
			vCurrency:=arrCurr{$row}
			setVecCurrency(vCurrency; True:C214)
		End if 
		GOTO OBJECT:C206(vAmount)
End case 
