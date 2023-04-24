If (Form event code:C388=On Clicked:K2:4)
	
	[ServerPrefs:27]dateEntryFilter:60:=Self:C308->{Self:C308->}
	OBJECT SET FILTER:C235(*; "vTestDateEntryFilter"; [ServerPrefs:27]dateEntryFilter:60)
	
End if 

