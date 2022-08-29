//%attributes = {}
checkGreaterThan(->[ServerPrefs:27]errorTolerance:4; "Warning Treshhold for Rate Deviation"; 0)
checkGreaterThan(->[ServerPrefs:27]minUpdateTime:17; "Min Update Time (in Mins)"; 4)
checkGreaterThan(->[ServerPrefs:27]updateFrequency:9; "Update Frequency"; [ServerPrefs:27]minUpdateTime:17)

If ([ServerPrefs:27]ReviewHighRiskAfterNDays:109>[ServerPrefs:27]ReviewCustomerAfterNDays:81)
	checkAddError("High Risk Customers should be reviewed sooner than non-high-risk customers!")
End if 

If ([ServerPrefs:27]errorTolerance:4>=0.5)
	checkAddWarning("Tolerance for changing currency rates is greater than 50%")
End if 

If (Not:C34([ServerPrefs:27]doFINTRACchecks:13))
	checkAddWarning("Compliance checks are turned off.")
End if 

If ((Old:C35([ServerPrefs:27]doComplyWithSkatteverket:65)=True:C214) & ([ServerPrefs:27]doComplyWithSkatteverket:65=False:C215))  // if this was on at some point in time
	checkAddWarningOnTrue((<>baseCurrency="SEK"); "You cannot turn off the compliance with Skatteverket!")
End if 

If ((<>baseCurrency="SEK") & ([ServerPrefs:27]doComplyWithSkatteverket:65=False:C215))  // if the user is turning off the compliance with Skatte
	checkAddWarning("If you are operating in Sweden, you should turn on compliance with Skatteverket")
End if 

If ((Old:C35([ServerPrefs:27]doComplyWithSkatteverket:65)=False:C215) & ([ServerPrefs:27]doComplyWithSkatteverket:65=True:C214))  // if the user just turned on compliance with Skatte
	
	checkAddWarningOnTrue((<>baseCurrency#"SEK"); "Are you sure you have to comply to Skatteverket (Swedish Tax Authority)?")
	checkAddWarningOnTrue((<>baseCurrency="SEK"); "Once the compliance with Skatteverket is turned ON, you cannot turn it OFF.")
End if 

checkAddWarningOnTrue((Year of:C25([ServerPrefs:27]toDate:35)<Year of:C25(Current date:C33)); "The Date Range seems to be incorrect!")
checkAddErrorIf(([ServerPrefs:27]toDate:35<[ServerPrefs:27]fromDate:34); "The Date Range is incorrect!")

checkAddWarningOnTrue(([ServerPrefs:27]warningLevel:28=0); "The warning level is on 'relax mode'. This setting is not recommended.")
checkIfNullString(->[ServerPrefs:27]administratorEmail:12; "Admin Email (2nd page)"; "WARN")
//checkIfNullString (->[ServerSettings]administratorCellNo;"Admin Cell Phone (2nd page)";"WARN")

//If (Modified record([ServerPrefs]))
//checkAddWarning ("You may have to restart the server for changes to take effect.")
//End if 

If ([ServerPrefs:27]currencyRateSource:113=2)
	C_TEXT:C284($tUsingOpenExchangeRates)
	$tUsingOpenExchangeRates:=getKeyValue("currency.rate.source.openexchangerates")
	If ($tUsingOpenExchangeRates#"true") & ([ServerPrefs:27]currencyRateSource:113=2)
		checkAddError("Certain key values must be configured before using the \"openexchangerates.org\" rates. Please contact support.")
	End if 
End if 