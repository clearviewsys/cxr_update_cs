C_DATE:C307(vTestDateEntryFilter; vTestDateDisplayFormat)

bindPopUpToIntegerField(Self:C308; ->[ServerPrefs:27]dateFormat:59)
OBJECT SET FORMAT:C236(*; "vTestDateDisplayFormat"; Char:C90(vDateFormat))
OBJECT SET FORMAT:C236(vTestDateEntryFilter; Char:C90(vDateFormat))
