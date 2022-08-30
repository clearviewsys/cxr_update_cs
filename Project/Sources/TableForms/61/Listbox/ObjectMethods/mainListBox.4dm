handleListBoxObjectMethod(Self:C308; Current form table:C627)
If (Form event code:C388=On Display Detail:K2:22)  //relation should be set in on display detail
	RELATE ONE:C42([States:61]CountryCode:2)  // load the Country Name
End if 

