// #ORDA

If (Form event code:C388=On Load:K2:1)
	Form:C1466.Rule:=ds:C1482.AML_AggrRules.new()
	Form:C1466.Rule.ifGroup:=""
	Form:C1466.Rule.ifOccupation:=""
	Form:C1466.Rule.ifNationality:=""
	Form:C1466.Rule.ifIndustryCode:=""
	
End if 