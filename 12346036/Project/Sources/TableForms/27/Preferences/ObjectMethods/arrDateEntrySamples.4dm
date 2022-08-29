If (False:C215)
	ARRAY TEXT:C222(arrDateEntrySamples; 0)
End if 

[ServerPrefs:27]dateEntryFilter:60:=arrDateEntrySamples{arrDateEntrySamples}
OBJECT SET FILTER:C235(*; "vTestDateEntryFilter"; [ServerPrefs:27]dateEntryFilter:60)
