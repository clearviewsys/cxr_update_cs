C_LONGINT:C283($selection)
C_DATE:C307($fromDate; $toDate)
$toDate:=Current date:C33

$selection:=Self:C308->

If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222(arrTitles; 8)
	arrTitles{1}:="Incoming"
	arrTitles{2}:="Outgoing"
	arrTitles{3}:="Total Volume"
	arrTitles{4}:="Max. Volume"
	arrTitles{5}:="No. of Buys"
	arrTitles{6}:="No. of Sells"
	arrTitles{7}:="Avg. Buy Volume"
	arrTitles{8}:="Avg. Sell Volume"
	
	ARRAY REAL:C219(arrCTR; 8)
	ARRAY REAL:C219(arrEFT; 8)
	$fromDate:=!00-00-00!
End if 

If (Form event code:C388=On Clicked:K2:4)
	
	Case of 
		: ($selection=1)  // since inception
			$fromDate:=!00-00-00!
			
		: ($selection=2)  // Last Review
			$fromDate:=[Customers:3]ReviewDate:97
			
		: ($selection=3)  // 6 months ago
			$fromDate:=Add to date:C393(Current date:C33; 0; -6; 0)
			
		: ($selection=4)  // 12 months ago
			$fromDate:=Add to date:C393(Current date:C33; 0; -12; 0)
			
		: ($selection=5)  // This year
			$fromDate:=calcBOYear
			
		: ($selection=6)  // Last year
			$fromDate:=newDate(1; 1; Year of:C25(Current date:C33)-1)  // last year Jan 1st 
			$toDate:=newDate(31; 12; Year of:C25(Current date:C33)-1)  // Dec 31, last year
	End case 
	
End if 

getCustomers_TrxStats([Customers:3]CustomerID:1; $fromDate; $toDate; ->arrCTR{1}; ->arrCtr{2}; ->arrCtr{3}; ->arrCTR{4}; ->arrCTR{5}; ->arrCtr{6}; ->arrCTR{7}; ->arrCTR{8}; 1)
getCustomers_TrxStats([Customers:3]CustomerID:1; $fromDate; $toDate; ->arrEFT{1}; ->arrEFT{2}; ->arrEFT{3}; ->arrEFT{4}; ->arrEFT{5}; ->arrEFT{6}; ->arrEFT{7}; ->arrEFT{8}; 2)
