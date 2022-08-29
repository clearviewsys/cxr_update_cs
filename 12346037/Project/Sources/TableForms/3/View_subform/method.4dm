// [Customers];"View"

handleViewForm
C_LONGINT:C283($formEvent)
C_TEXT:C284(vCustomerAddress)
$formEvent:=Form event code:C388

If (($formEvent=On Outside Call:K2:11) | ($formEvent=On Load:K2:1))
	// Note: adding the  | ($formevent=On Clicked ) will create a problem that every time you click on a subrecord
	// it will jump to the top
	
	If ([Customers:3]AddressUnitNo:148="")
		vCustomerAddress:=env_makeAddressText([Customers:3]Address:7; [Customers:3]City:8; [Customers:3]Province:9; [Customers:3]PostalCode:10; [Customers:3]Country_obs:11)
	Else 
		vCustomerAddress:=env_makeAddressText([Customers:3]AddressUnitNo:148+"-"+[Customers:3]Address:7; [Customers:3]City:8; [Customers:3]Province:9; [Customers:3]PostalCode:10; [Customers:3]Country_obs:11)
	End if 
	
	getLatestCheckLogStatusIcon(Table:C252(->[Customers:3]); [Customers:3]CustomerID:1; ->picCheckListStatus; makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4))
	OBJECT SET VISIBLE:C603(*; "l_needsReview"; isCustomerDueForKYCReview)
	handleCustomerRedFlagSigns
	
End if 

If (($formEvent=On Load:K2:1) | ($formEvent=On Page Change:K2:54) | ($formEvent=On Outside Call:K2:11))
	handleCustomerViewTab
End if 