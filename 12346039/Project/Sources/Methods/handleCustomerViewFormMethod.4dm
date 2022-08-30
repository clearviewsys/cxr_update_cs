//%attributes = {}
// [Customers];"View"

handleViewForm(->[Customers:3])
C_LONGINT:C283($formEvent)
C_TEXT:C284(vCustomerAddress)
C_PICTURE:C286(picCheckListStatus)

$formEvent:=Form event code:C388

If (($formEvent=On Outside Call:K2:11) | ($formEvent=On Load:K2:1))  // when the form loads or the current record is changed 
	// Note: adding the  | ($formevent=On Clicked ) will create a problem that every time you click on a subrecord
	// it will jump to the top
	
	If ([Customers:3]AddressUnitNo:148="")
		vCustomerAddress:=env_makeAddressText([Customers:3]Address:7; [Customers:3]City:8; [Customers:3]Province:9; [Customers:3]PostalCode:10; [Customers:3]Country_obs:11)
	Else 
		vCustomerAddress:=env_makeAddressText([Customers:3]AddressUnitNo:148+"-"+[Customers:3]Address:7; [Customers:3]City:8; [Customers:3]Province:9; [Customers:3]PostalCode:10; [Customers:3]Country_obs:11)
	End if 
	
	getLatestCheckLogStatusIcon(Table:C252(->[Customers:3]); [Customers:3]CustomerID:1; ->picCheckListStatus; makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4))
	handleCustomerRedFlagSigns
	drawRiskBar("riskBar"; [Customers:3]AML_RiskRating:75)
End if 

If (($formEvent=On Load:K2:1) | ($formEvent=On Page Change:K2:54) | ($formEvent=On Outside Call:K2:11))
	// outside call is when the record is forwarded with arrows on top of the screen or if the user searches
	C_POINTER:C301($tabPtr)
	$tabPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "tab_Customer")
	handleCustomerViewTab($tabPtr)
End if 