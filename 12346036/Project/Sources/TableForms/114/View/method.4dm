HandleEntryFormMethod(Current form table:C627)

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Outside Call:K2:11))
	//SET FIELD RELATION([Occupations]IndustryCode;Do not modify;Automatic)  // activate many relations
	RELATE MANY:C262([Industries:114]Code:6)
End if 
