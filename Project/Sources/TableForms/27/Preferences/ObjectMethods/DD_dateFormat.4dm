
If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Clicked:K2:4))
	bindPopUpToIntegerField(Self:C308; ->[ServerPrefs:27]dateFormat:59)
	OBJECT SET FORMAT:C236(*; "vTestDateDisplayFormat"; Char:C90(Self:C308->))
	OBJECT SET FORMAT:C236(*; "vTestDateEntryFilter"; Char:C90(Self:C308->))
End if 

