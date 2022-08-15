//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 04/11/18, 22:21:13
// ----------------------------------------------------
// Method: 
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_POINTER:C301($1)  //option names
C_POINTER:C301($2)  //option values
C_POINTER:C301($3)  //optons labels

webSelectAgentRecord

QUERY:C277([Accounts:9]; [Accounts:9]AgentID:16=[Agents:22]AgentID:1)

ORDER BY:C49([Accounts:9]; [Accounts:9]Currency:6; >)

SELECTION TO ARRAY:C260([Accounts:9]AccountID:1; $1->)