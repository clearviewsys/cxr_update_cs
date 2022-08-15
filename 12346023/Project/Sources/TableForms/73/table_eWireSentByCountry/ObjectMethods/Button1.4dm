C_DATE:C307(vFromDate; vToDate)
C_LONGINT:C283(cbApplyDateRange)


ARRAY TEXT:C222(arr_country; 0)
ARRAY LONGINT:C221(arr_qtySent; 0)
ARRAY REAL:C219(arr_AmountSent; 0)

C_LONGINT:C283($n; $i)

If (cbApplyDateRange=1)
	QUERY:C277([eWires:13]; [eWires:13]isPaymentSent:20=True:C214; *)
	QUERY:C277([eWires:13];  & ; [eWires:13]SendDate:2>=vFromDate; *)
	QUERY:C277([eWires:13];  & ; [eWires:13]SendDate:2<=vToDate)
Else 
	QUERY:C277([eWires:13]; [eWires:13]isPaymentSent:20=True:C214)
End if 

DISTINCT VALUES:C339([eWires:13]toCountry:10; arr_country)
$n:=Size of array:C274(arr_Country)
ARRAY LONGINT:C221(arr_qtySent; $n)
ARRAY REAL:C219(arr_AmountSent; $n)

C_TEXT:C284($country)
For ($i; 1; $n)
	$country:=arr_Country{$i}
	QUERY:C277([eWires:13]; [eWires:13]toCountry:10=$country)
	
	arr_qtySent{$i}:=Records in selection:C76([eWires:13])
	
	// find all register related to all of the eWires selected
	RELATE ONE SELECTION:C349([eWires:13]; [Registers:10])
	
	arr_amountSent{$i}:=Sum:C1([Registers:10]CreditLocal:24)  // these should be all the local currency
	
End for 