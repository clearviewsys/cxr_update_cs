C_POINTER:C301($self)
C_BOOLEAN:C305($isSelf)
$self:=Self:C308
$isSelf:=numToBoolean($self->)

If (Form event code:C388=On Load:K2:1)
	$isself:=([WireTemplates:42]relationship:34="self")
	$self->:=Num:C11($isSelf)
End if 

If (Form event code:C388=On Clicked:K2:4)
	If ($isSelf)
		[WireTemplates:42]BeneficiaryFullName:9:=[Customers:3]FullName:40
		[WireTemplates:42]BeneficiaryCountryCode:27:=[Customers:3]CountryCode:113
		[WireTemplates:42]relationship:34:="self"
		[WireTemplates:42]BeneficiaryAddress:19:=[Customers:3]Address:7
		[WireTemplates:42]BeneficiaryCity:24:=[Customers:3]City:8
		[WireTemplates:42]BeneficiaryGender:32:=[Customers:3]Gender:120
		[WireTemplates:42]Phone:15:=[Customers:3]HomeTel:6
		[WireTemplates:42]BeneficiaryState:25:=[Customers:3]Province:9
		[WireTemplates:42]BeneficiaryZIPCode:26:=[Customers:3]PostalCode:10
	Else 
		[WireTemplates:42]BeneficiaryFullName:9:=Old:C35([WireTemplates:42]BeneficiaryFullName:9)
		[WireTemplates:42]BeneficiaryCountryCode:27:=Old:C35([WireTemplates:42]BeneficiaryCountryCode:27)
		[WireTemplates:42]relationship:34:=Old:C35([WireTemplates:42]relationship:34)
		[WireTemplates:42]BeneficiaryAddress:19:=Old:C35([WireTemplates:42]BeneficiaryAddress:19)
		[WireTemplates:42]BeneficiaryCity:24:=Old:C35([WireTemplates:42]BeneficiaryCity:24)
		[WireTemplates:42]BeneficiaryGender:32:=Old:C35([WireTemplates:42]BeneficiaryGender:32)
		[WireTemplates:42]Phone:15:=Old:C35([WireTemplates:42]Phone:15)
		[WireTemplates:42]BeneficiaryState:25:=Old:C35([WireTemplates:42]BeneficiaryState:25)
		[WireTemplates:42]BeneficiaryZIPCode:26:=Old:C35([WireTemplates:42]BeneficiaryZIPCode:26)
	End if 
End if 