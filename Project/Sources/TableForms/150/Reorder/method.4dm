
If (Form event code:C388=On Load:K2:1)
	READ ONLY:C145([AML_AggrRules:150])
	allRecordsAML_AggrRules
	ARRAY INTEGER:C220(arrRuleNo; 0)
	ARRAY TEXT:C222(arrRuleName; 0)
	ARRAY TEXT:C222(arrDescription; 0)
	ARRAY BOOLEAN:C223(arrIsActive; 0)
	ARRAY BOOLEAN:C223(arrStop; 0)
	ARRAY TEXT:C222(arrUUID; 0)
	
	SELECTION TO ARRAY:C260([AML_AggrRules:150]UUID:1; arrUUID; [AML_AggrRules:150]rowNo:47; arrRuleNo; [AML_AggrRules:150]ruleName:2; arrRuleName; [AML_AggrRules:150]description:3; arrDescription; [AML_AggrRules:150]isActive:4; arrIsActive; [AML_AggrRules:150]thenStop:46; arrStop)
End if 