//%attributes = {}
// handleTabCurrenciesView

C_DATE:C307(vFromDate; vToDate)
C_LONGINT:C283(cbApplyDateRange)

Case of 
	: (tabCurrencies=1)  // journal registers
		handleTabCurrenciesView_Reg
		
	: (tabCurrencies=2)  // Accounts
		handleTabCurrenciesView_Accnts
		
	: (tabCurrencies=3)  // performance summary
		// for optimization sake, moved the code to a button
		
	: (tabCurrencies=4)  // 
		QUERY:C277([Denominations:31]; [Denominations:31]Currency:2=[Currencies:6]ISO4217:31)
		orderByDenominations
		
	: (tabCurrencies=5)
		//handleDrawYahooChart 
		//http://finance.yahoo.com/charts?s=AUDUSD=X#symbol=;range=20111206,20121129;compare=;indicator=volume;charttype=area;crosshair=on;ohlcvalues=0;logscale=off;source=undefined;
		//http://finance.yahoo.com/charts?s=AUDUSD=X#symbol=;range=1y;compare=;indicator=volume;charttype=area;crosshair=on;ohlcvalues=0;logscale=off;source=undefined;
		C_TEXT:C284($code; $url)
		$code:=[Currencies:6]ISO4217:31+[Currencies:6]toISO4217:32
		// https://finance.yahoo.com/quote/AUDUSD%3DX/chart?p=AUDUSD%3DX#eyJpbnRlcnZhbCI6ImRheSIsInBlcmlvZGljaXR5IjoxLCJ0aW1lVW5pdCI6bnVsbCwiY2FuZGxlV2lkdGgiOjQuMTYwNzE0Mjg1NzE0Mjg2LCJ2b2x1bWVVbmRlcmxheSI6dHJ1ZSwiYWRqIjp0cnVlLCJjcm9zc2hhaXIiOnRydWUsImNoYXJ0VHlwZSI6ImxpbmUiLCJleHRlbmRlZCI6ZmFsc2UsIm1hcmtldFNlc3Npb25zIjp7fSwiYWdncmVnYXRpb25UeXBlIjoib2hsYyIsImNoYXJ0U2NhbGUiOiJsaW5lYXIiLCJzdHVkaWVzIjp7InZvbCB1bmRyIjp7InR5cGUiOiJ2b2wgdW5kciIsImlucHV0cyI6eyJpZCI6InZvbCB1bmRyIiwiZGlzcGxheSI6InZvbCB1bmRyIn0sIm91dHB1dHMiOnsiVXAgVm9sdW1lIjoiIzAwYjA2MSIsIkRvd24gVm9sdW1lIjoiI0ZGMzMzQSJ9LCJwYW5lbCI6ImNoYXJ0IiwicGFyYW1ldGVycyI6eyJoZWlnaHRQZXJjZW50YWdlIjowLjI1LCJ3aWR0aEZhY3RvciI6MC40NSwiY2hhcnROYW1lIjoiY2hhcnQifX19LCJwYW5lbHMiOnsiY2hhcnQiOnsicGVyY2VudCI6MSwiZGlzcGxheSI6IkFVRFVTRD1YIiwiY2hhcnROYW1lIjoiY2hhcnQiLCJ0b3AiOjB9fSwic2V0U3BhbiI6bnVsbCwibGluZVdpZHRoIjoyLCJzdHJpcGVkQmFja2dyb3VkIjp0cnVlLCJldmVudHMiOnRydWUsImNvbG9yIjoiIzAwODFmMiIsInN5bWJvbHMiOlt7InN5bWJvbCI6IkFVRFVTRD1YIiwic3ltYm9sT2JqZWN0Ijp7InN5bWJvbCI6IkFVRFVTRD1YIn0sInBlcmlvZGljaXR5IjoxLCJpbnRlcnZhbCI6ImRheSIsInRpbWVVbml0IjpudWxsLCJzZXRTcGFuIjpudWxsfV19
		$url:="http://chart.finance.yahoo.com/z?s="+$code+"%3dX&t=3m&q=l&l=on&z=l&a=v&p=s&lang=en-US&region=US"
		//$url:="http://finance.yahoo.com/q/bc?t=3m&s="+$code+"+%3DX&l=off&z=l&q=l&c=&ql=1&c=%5EGSPC&c=%5EIXIC"
		WA OPEN URL:C1020(waCurrencyPage; $url)
End case 