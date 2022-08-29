//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 04/11/18, 22:21:13
// ----------------------------------------------------
// Method: WAPI_getCurrencyArray
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_POINTER:C301($1)  //option names
C_POINTER:C301($2)  //option values
C_POINTER:C301($3)  //optons labels

webSelectAgentRecord

QUERY:C277([AgentAccounts:126]; [AgentAccounts:126]agentID:3=[Agents:22]AgentID:1)


ORDER BY:C49([AgentAccounts:126]; [AgentAccounts:126]reserved:4; >)
//SELECTION TO ARRAY([AgentAccounts]currencyCode;$1->)
SELECTION TO ARRAY:C260([AgentAccounts:126]agentAccountsID:2; $1->)