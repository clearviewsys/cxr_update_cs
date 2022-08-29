handleViewForm(Current form table:C627)

OBJECT SET TITLE:C194(*; "status"; getOrderStatusText([Orders:95]orderStatus:11))

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Outside Call:K2:11))
	QUERY:C277([OrderLines:96]; [OrderLines:96]orderID:2=[Orders:95]orderID:1)
	QUERY SELECTION:C341([OrderLines:96]; [OrderLines:96]QtyOrdered:5>0)
	
	ORDER BY:C49([OrderLines:96]; [OrderLines:96]Curr:3; >; [OrderLines:96]denomination:4; <)
	
	SELECTION TO ARRAY:C260([OrderLines:96]Curr:3; arrCurr; [OrderLines:96]denomination:4; arrDenoms; [OrderLines:96]QtyOrdered:5; arrQty; [OrderLines:96]orderValue:14; arrTotals)
	
	
	DISTINCT VALUES:C339([OrderLines:96]Curr:3; ARRCURRENCIES)
	SORT ARRAY:C229(ARRCURRENCIES)
	C_LONGINT:C283($i; $n)
	$n:=Size of array:C274(ARRCURRENCIES)
	ARRAY REAL:C219(arrAmounts; $n)
	ARRAY PICTURE:C279(arrFlags; $n)
	ARRAY REAL:C219(arrValues; $n)
	C_TEXT:C284($curr)
	
	For ($i; 1; $n)
		$curr:=ARRCURRENCIES{$i}
		selectCurrencyByISOCode($curr)
		ARRFLAGS{$i}:=[Currencies:6]Flag:3
		arrAmounts{$i}:=getTotalOrderForCurrencyByOrder([Orders:95]orderID:1; $curr)
		arrValues{$i}:=roundToBase(arrAmounts{$i}*[Currencies:6]SpotRateLocal:17)
	End for 
	
End if 

