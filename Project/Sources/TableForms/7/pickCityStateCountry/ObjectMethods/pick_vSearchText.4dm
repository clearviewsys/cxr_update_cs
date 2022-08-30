//pick_handleAutoFillSearch (Self;Current form table;->[Customers]CustomerID;->[Customers];->[Customers]CustomerID;->arrKey;->arrValue)
//pick_autoFill_ (Current form table)
C_TEXT:C284($variable)
C_TEXT:C284(pick_vSearchText)

$variable:=Self:C308->
C_TEXT:C284(vMatches)

If ((Form event code:C388=On Getting Focus:K2:7) | (Form event code:C388=On After Keystroke:K2:26))
	$variable:=Get edited text:C655
	
	SET QUERY LIMIT:C395(<>queryLimit)
	QUERY:C277([Cities:60]; [Cities:60]CityName:1=$variable+"@")
	SET QUERY LIMIT:C395(0)
	
	ARRAY BOOLEAN:C223(arrCityStateCountry; 0)
	//REDRAW("arrCitySateCountry")
	vMatches:=String:C10(Records in selection:C76([Cities:60]))+" record(s)"
	REDRAW:C174(vMatches)
	If (Records in selection:C76([Cities:60])=0)
		BEEP:C151
	Else 
		SELECTION TO ARRAY:C260([Cities:60]CityName:1; arrCities; [Cities:60]StateCode:2; arrStates; [Cities:60]CountryCode:4; arrCountries)
		arrCityStateCountry:=1  // select the first element
		//arrCityStateCountry{1}:=True
	End if 
End if 

If (Form event code:C388=On Losing Focus:K2:8)
	//If (Records in selection($tablePtr->)#0)
	//FIRST RECORD($tablePtr->)
	//$varPtr->:=$fieldPtr->
	//SET VISIBLE($4->;False)
	//Else 
	//BEEP
	//GOTO AREA($1->)
	//End if 
End if 
