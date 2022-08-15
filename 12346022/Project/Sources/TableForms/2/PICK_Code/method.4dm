handlepickFormMethod

If (Form event code:C388=On Load:K2:1)
	SET FIELD RELATION:C919([Occupations:2]Category:5; Automatic:K51:4; Structure configuration:K51:2)
End if 

If (Form event code:C388=On Unload:K2:2)
	SET FIELD RELATION:C919([Occupations:2]Category:5; Structure configuration:K51:2; Structure configuration:K51:2)
	
End if 