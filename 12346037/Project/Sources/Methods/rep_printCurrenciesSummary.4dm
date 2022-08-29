//%attributes = {"shared":true}


C_TEXT:C284($formName; $tBranch)
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
	C_BOOLEAN:C305(vbAltKey)
	vbAltKey:=Macintosh option down:C545  //10/12/16 IBB
	
	If (Count parameters:C259=0)
		requestDateRangeTable(->[Registers:10]; ->[Registers:10]RegisterDate:2; True:C214)
	End if 
	
	
	If (OK=1)
		
		If (vbAltKey)  //10/11/16 IBB added for Blake
			$tBranch:=getBranchID
			CONFIRM:C162("Report ONLY for "+$tBranch+"?")
			If (OK=1)
				QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterID:1=($tBranch+"@"))
			End if 
		End if 
		
		READ ONLY:C145([Currencies:6])
		
		RELATE ONE SELECTION:C349([Registers:10]; [Currencies:6])  // select only the currencies that are in that date range
		ORDER BY:C49([Currencies:6]; [Currencies:6]hasChequeAccount:24; <; [Currencies:6]CurrencyCode:1)
		printSettings
		If (OK=1)
			printFormsTable(->[Currencies:6]; ->[Currencies:6]hasChequeAccount:24; $formName; "calculateHoldingsSumVars"; "Currency Holdings Report"; True:C214; True:C214; True:C214)
		End if 
	End if 
Else 
	myAlert("Please ask the administrator to grant you access to this menu.")
End if 
