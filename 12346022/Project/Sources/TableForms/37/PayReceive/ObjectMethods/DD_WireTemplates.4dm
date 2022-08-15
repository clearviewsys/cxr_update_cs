
C_POINTER:C301(wtPtr)
wtPtr:=Self:C308

handleDropDown_WireTemplates(Self:C308; ->[AccountInOuts:37]WireTemplateID:27; VCUSTOMERID; Form event code:C388)

RELATE ONE:C42([AccountInOuts:37]WireTemplateID:27)
[Invoices:5]AMLCountryCode:87:=[WireTemplates:42]BeneficiaryCountryCode:27

If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	[AccountInOuts:37]Memo:10:=serializeWireTemplate
End if 