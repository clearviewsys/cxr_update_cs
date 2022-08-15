//ALERT(String(Form event code))

handleCustomerViewFormMethod
//handleCustomerViewTab

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11))
	If ([Customers:3]isCompany:41)
		OBJECT SET SUBFORM:C1138(*; "subform_mainInfo"; [Customers:3]; "subform_company")
	Else 
		// [customers];"subform_individual"
		OBJECT SET SUBFORM:C1138(*; "subform_mainInfo"; [Customers:3]; "subform_individual")
	End if 
	C_POINTER:C301($pep; $hio)
	$pep:=OBJECT Get pointer:C1124(Object named:K67:5; "isPEP")
	$hio:=OBJECT Get pointer:C1124(Object named:K67:5; "isHIO")
	
	handleTristateCheckBox($pep; ->[Customers:3]AML_isPEP:80; "Is PEP?"; "Customer is PEP!"; "Not a PEP!"; Dark grey:K11:12; Red:K11:4; Blue:K11:7; On Load:K2:1)
	handleTristateCheckBox($hio; ->[Customers:3]AML_isHIO:124; "HIO ?"; "Customer is HIO"; "Customer is not HIO!"; Dark grey:K11:12; Red:K11:4; Blue:K11:7; On Load:K2:1)
	
End if 

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11))
	displayCustomersLInkedDocs
End if 
