
C_LONGINT:C283($formEvent)
C_TEXT:C284(vCustomerAddress)
$formEvent:=Form event code:C388

If ($formEvent=On Printing Detail:K2:18)
	handlePhoneField(->[Customers:3]HomeTel:6)
	handlePhoneField(->[Customers:3]WorkTel:12)
	handlePhoneField(->[Customers:3]WorkFax:46)
	handlePhoneField(->[Customers:3]CellPhone:13)
	If ([Customers:3]AddressUnitNo:148="")
		vCustomerAddress:=env_makeAddressText([Customers:3]Address:7; [Customers:3]City:8; [Customers:3]Province:9; [Customers:3]PostalCode:10; [Customers:3]Country_obs:11)
	Else 
		vCustomerAddress:=env_makeAddressText([Customers:3]AddressUnitNo:148+"-"+[Customers:3]Address:7; [Customers:3]City:8; [Customers:3]Province:9; [Customers:3]PostalCode:10; [Customers:3]Country_obs:11)
	End if 
End if 