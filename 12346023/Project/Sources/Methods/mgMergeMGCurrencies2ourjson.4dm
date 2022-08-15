//%attributes = {}
C_OBJECT:C1216($mgCredentials; $result; $ourCurrencies; $oneMGCurrency)
C_COLLECTION:C1488($notPresent)

$mgCredentials:=mgGetCredentials
$ourCurrencies:=mgGetCurrencies

$result:=mgSOAP_RunMethod($mgCredentials; "GetCurrencies")

If ($result#Null:C1517)
	
	If ($result.result#Null:C1517)
		
		For each ($oneMGCurrency; $result.result)
			
			If ($ourCurrencies[$oneMGCurrency.CurrencyACode]#Null:C1517)
				$ourCurrencies[$oneMGCurrency.CurrencyACode].id:=$oneMGCurrency.Currency
			Else 
				If ($notPresent=Null:C1517)
					$notPresent:=New collection:C1472
				End if 
				$notPresent.push($oneMGCurrency)
			End if 
			
		End for each 
		
		// save to JSON file
		
		C_TEXT:C284($path)
		$path:=System folder:C487(Desktop:K41:16)+"currenciesnew.json"
		
		TEXT TO DOCUMENT:C1237($path; JSON Stringify:C1217($ourCurrencies; *))
		
	End if 
	
End if 
