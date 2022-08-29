//%attributes = {}
// fixMissingCountryCodes

C_TEXT:C284($countryName; $countryCode)
ARRAY TEXT:C222($arrCountries; 0)
C_LONGINT:C283($i; $j; $n)
C_TEXT:C284($tableName)


Sync_Control("Trigger_OFF")

For ($j; 1; 8)  // for each table
	
	Case of 
		: ($j=1)
			$tableName:="Links"
			QUERY:C277([Links:17]; [Links:17]countryCode:50="")  // links 
			DISTINCT VALUES:C339([Links:17]Country:12; $arrCountries)
			
		: ($j=2)  // wire templates when j=2
			$tableName:="Wire Templates"
			QUERY:C277([WireTemplates:42]; [WireTemplates:42]BankCountryCode:35="")
			DISTINCT VALUES:C339([WireTemplates:42]BankCountry:12; $arrCountries)
			
		: ($j=3)
			$tableName:="Agents"
			QUERY:C277([Agents:22]; [Agents:22]CountryCode:21="")
			DISTINCT VALUES:C339([Agents:22]CountryCode:21; $arrCountries)
			
		: ($j=4)
			$tableName:="Accounts"
			QUERY:C277([Accounts:9]; [Accounts:9]isForeignAccount:15=True:C214; *)
			QUERY:C277([Accounts:9];  & ; [Accounts:9]CountryCode:39="")
			DISTINCT VALUES:C339([Accounts:9]AgentID:16; $arrCountries)
			
		: ($j=5)
			$tableName:="Customers"
			QUERY:C277([Customers:3]; [Customers:3]CountryCode:113="")
			DISTINCT VALUES:C339([Customers:3]CountryCode:113; $arrCountries)
			
		: ($j=6)
			$tableName:="Customers"
			QUERY:C277([Customers:3]; [Customers:3]CitizenshipCountryCode:22="")  // citizenship
			DISTINCT VALUES:C339([Customers:3]Citizenship_obs:60; $arrCountries)
			
		: ($j=7)
			$tableName:="Customers"
			QUERY:C277([Customers:3]; [Customers:3]CountryOfResidenceCode:114="")  // residence
			DISTINCT VALUES:C339([Customers:3]CountryOfResidence_obs:61; $arrCountries)
			
		: ($j=8)
			$tableName:="Customers"
			QUERY:C277([Customers:3]; [Customers:3]CountryOfBirthCode:18="")  // nationality
			DISTINCT VALUES:C339([Customers:3]Nationality:91; $arrCountries)
			
	End case 
	
	$n:=Size of array:C274($arrCountries)
	myAlert("Found <X> records that need to be fixed in <Y>"; ""; String:C10($n); $tableName)
	
	For ($i; 1; $n)
		$countryName:=$arrCountries{$i}
		$countryCode:=getCountryCode($arrCountries{$i})
		If ($countryCode="")
			$countryCode:=myRequest("What's the country code for "+$countryName)
		End if 
		
		If ($countryCode="-")
			ABORT:C156
		End if 
		
		If ($countryCode#"")
			ASSERT:C1129((Length:C16($countryCode)=2); "Country code must be 2 digits")
			Case of 
				: ($j=1)  // links
					ASSERT:C1129($j=1)
					QUERY:C277([Links:17]; [Links:17]Country:12=$countryName; *)  // links that have country name but no country code
					QUERY:C277([Links:17];  & ; [Links:17]countryCode:50="")
					READ WRITE:C146([Links:17])
					APPLY TO SELECTION:C70([Links:17]; [Links:17]countryCode:50:=$countryCode)
					READ ONLY:C145([Links:17])
					
				: ($j=2)  // wire templates
					ASSERT:C1129($j=2)
					QUERY:C277([WireTemplates:42]; [WireTemplates:42]BankCountry:12=$countryName; *)
					QUERY:C277([WireTemplates:42];  & ; [WireTemplates:42]BankCountryCode:35="")
					READ WRITE:C146([WireTemplates:42])
					
					APPLY TO SELECTION:C70([WireTemplates:42]; [WireTemplates:42]BankCountryCode:35:=$countryCode)
					APPLY TO SELECTION:C70([WireTemplates:42]; [WireTemplates:42]BeneficiaryCountryCode:27:=$countryCode)
					READ ONLY:C145([WireTemplates:42])
					
				: ($j=3)  // agents
					ASSERT:C1129($j=3)
					QUERY:C277([Agents:22]; [Agents:22]Country:5=$countryName; *)
					QUERY:C277([Agents:22];  & ; [Agents:22]CountryCode:21="")
					READ WRITE:C146([Agents:22])
					
					APPLY TO SELECTION:C70([Agents:22]; [Agents:22]CountryCode:21:=$countryCode)
					READ ONLY:C145([Agents:22])
					
					
				: ($j=4)  // accounts
					//ASSERT($j=4)
					//QUERY([Accounts];[Accounts]isForeignAccount=True;*)
					//QUERY([Accounts]; & ;[Accounts]isForeignAccount=True;*)
					//QUERY([Accounts]; & ;[Accounts]CountryCode="")
					//READ WRITE([Accounts])
					//APPLY TO SELECTION([Accounts];[Accounts]CountryCode:=$countryCode)
					//READ ONLY([Accounts])
					
				: ($j=5)  // Customers country code
					
					ASSERT:C1129($j=5)
					QUERY:C277([Customers:3]; [Customers:3]CountryCode:113=$countryName; *)
					QUERY:C277([Customers:3];  & ; [Customers:3]CountryCode:113="")
					READ WRITE:C146([Customers:3])
					APPLY TO SELECTION:C70([Customers:3]; [Customers:3]CountryCode:113:=$countryCode)
					READ ONLY:C145([Customers:3])
					
				: ($j=6)  // Customers citizenship
					
					ASSERT:C1129($j=6)
					QUERY:C277([Customers:3]; [Customers:3]Citizenship_obs:60=$countryName; *)
					QUERY:C277([Customers:3];  & ; [Customers:3]CitizenshipCountryCode:22="")
					READ WRITE:C146([Customers:3])
					APPLY TO SELECTION:C70([Customers:3]; [Customers:3]CitizenshipCountryCode:22:=$countryCode)
					READ ONLY:C145([Customers:3])
					
				: ($j=7)  // Customers residence
					
					ASSERT:C1129($j=7)
					QUERY:C277([Customers:3]; [Customers:3]CountryOfResidence_obs:61=$countryName; *)
					QUERY:C277([Customers:3];  & ; [Customers:3]CountryOfResidenceCode:114="")
					READ WRITE:C146([Customers:3])
					APPLY TO SELECTION:C70([Customers:3]; [Customers:3]CountryOfResidenceCode:114:=$countryCode)
					READ ONLY:C145([Customers:3])
					
				: ($j=8)  // Customers nationality
					
					ASSERT:C1129($j=8)
					QUERY:C277([Customers:3]; [Customers:3]Nationality:91=$countryName; *)
					QUERY:C277([Customers:3];  & ; [Customers:3]CountryOfBirthCode:18="")
					READ WRITE:C146([Customers:3])
					APPLY TO SELECTION:C70([Customers:3]; [Customers:3]CountryOfBirthCode:18:=$countryCode)
					READ ONLY:C145([Customers:3])
			End case 
			
		Else   // countrycode is null
			// skip the loop
		End if   // if (CountryCode#")"
		
	End for   // i
End for   // j

Sync_Control("Trigger_ON")
