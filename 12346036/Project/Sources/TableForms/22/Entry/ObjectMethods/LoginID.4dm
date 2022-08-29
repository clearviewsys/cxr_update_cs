checkInit
checkUniqueness(->[WebUsers:14]; ->[WebUsers:14]webUsername:1; ->[Agents:22]AgentID:1; "Login ID")
If (checkErrorExist)
	ALERT:C41(checkGetErrorString)
End if 
sl_handleAgentScreening(sl_AgentsPerson+sl_ForInputBox)

//If ([Agents]AgentID#"")
//OBJECT SET ENABLED(*; "b_check"; True)
//sl_handlePersonNameCompliance(False; [Agents]FullName; ->[Agents]AgentID)
//Else
//OBJECT SET ENABLED(*; "b_check"; False)
//End if
