//%attributes = {"shared":true}
// this is similar to rep_printCurrenciesSummary
// except that is omits the 'omitted' accounts from the report. needs testing


C_TEXT:C284($formName)
C_DATE:C307(vFromDate; vToDate)

C_REAL:C285(vSumInventory; vSumInventoryShort; vSumVolumeSold; vSumCOGS; vSumNetProfits; vSumFeesReceived; vSumSalesProfits)
$formName:="rep_Currencies"

vSumInventory:=0
vSumInventoryShort:=0
vSumVolumeSold:=0
vSumCOGS:=0
vSumNetProfits:=0
vSumFeesReceived:=0
vSumSalesProfits:=0


If (isUserAllowedToPrintReports)
	If (Count parameters:C259=0)
		requestDateRangeTable(->[Registers:10]; ->[Registers:10]RegisterDate:2; True:C214)
	End if 
	
	
	If (OK=1)
		READ ONLY:C145([Currencies:6])
		
		RELATE ONE SELECTION:C349([Registers:10]; [Currencies:6])  // select only the currencies that are in that date range
		ORDER BY:C49([Currencies:6]; [Currencies:6]hasChequeAccount:24; <; [Currencies:6]CurrencyCode:1)
		printSettings
		If (OK=1)
			printFormsTable(->[Currencies:6]; ->[Currencies:6]hasChequeAccount:24; $formName; "calculateHoldingsSumVars2"; "Currency Holdings Report ver 2.0"; True:C214; True:C214; True:C214)
		End if 
	End if 
Else 
	myAlert("Please ask the administrator to grant you access to this menu.")
End if 
