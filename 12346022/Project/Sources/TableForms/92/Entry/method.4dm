HandleEntryFormMethod
If (Form event code:C388=On Load:K2:1)
	OBJECT SET VISIBLE:C603(*; "fintrac@"; (<>COUNTRYCODE="CA"))  // turn on the fintrac fields
	OBJECT SET VISIBLE:C603(*; "ptr@"; (<>COUNTRYCODE="NZ"))  // turn on the fintrac fields
End if 

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4))
	OBJECT SET FILTER:C235(*; "testString"; [PictureIDTypes:92]EntryFilter:11)
	OBJECT SET FORMAT:C236(*; "testString"; [PictureIDTypes:92]DisplayFormat:13)
	
	
End if 