// handlePickListObjectMethod ({->listBox})

//C_POINTER($1;$listBoxPtr)  ` Jan 16, 2012 17:53:10 -- I.Barclay Berry 
C_POINTER:C301($listBoxPtr)
C_BOOLEAN:C305(didPickRecentCity)
$listBoxPtr:=Focus object:C278


//If (Form event=On Load )
//$listBoxPtr->{1}:=True  ` select first item
//End if   ` 

If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Selection Change:K2:29))
	GOTO SELECTED RECORD:C245([Cities:60]; arrCities)
	RELATE ONE:C42([Cities:60]CountryCode:4)
	RELATE ONE:C42([Cities:60]StateCode:2)
	didPickRecentCity:=False:C215
End if 


If (Form event code:C388=On Double Clicked:K2:5)
	didPickRecentCity:=False:C215
	addRecentCity
	ACCEPT:C269
End if 


