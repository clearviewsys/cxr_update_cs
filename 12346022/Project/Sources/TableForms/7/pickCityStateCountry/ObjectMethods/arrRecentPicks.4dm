// handlePickListObjectMethod ({->listBox})

//C_POINTER($1;$listBoxPtr) ` Jan 16, 2012 17:54:38 -- I.Barclay Berry 

C_POINTER:C301($listBoxPtr)

$listBoxPtr:=Focus object:C278
C_BOOLEAN:C305(didPickRecentCity)

If (Form event code:C388=On Load:K2:1)
	//$listBoxPtr->{1}:=True  ` select first item
	fillRecentPicksListBox
End if   // 

If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Selection Change:K2:29))
	//GOTO SELECTED RECORD([Cities];arrCities)
	
	ARRAY TEXT:C222($arrTokens; 3)
	C_TEXT:C284($string; $city; $province; $country)
	$string:=arrRecentCities{listbox_getSelectedRowNumber($listboxPtr)}
	// API Text To Array ($string;",";$arrTokens)
	STR_SplitToArray($string; ","; ->$arrTokens)  // replacement method for API plugin call
	If (Size of array:C274($arrTokens)=3)
		$city:=$arrTokens{1}
		$province:=$arrTokens{2}
		$country:=$arrTokens{3}
		
		QUERY:C277([Cities:60]; [Cities:60]CityName:1=$city; *)
		QUERY:C277([Cities:60];  & ; [Cities:60]StateCode:2=$province; *)
		QUERY:C277([Cities:60];  & ; [Cities:60]CountryCode:4=$country)
		
		RELATE ONE:C42([Cities:60]CountryCode:4)
		RELATE ONE:C42([Cities:60]StateCode:2)
		didPickRecentCity:=True:C214
	End if 
End if 


If (Form event code:C388=On Double Clicked:K2:5)
	didPickRecentCity:=True:C214
	ACCEPT:C269
End if 


