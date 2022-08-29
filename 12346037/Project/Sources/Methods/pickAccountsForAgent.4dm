//%attributes = {}
// pickAccountForAgent (object;agent;{request string})

C_POINTER:C301($1)
C_TEXT:C284($2; vAgentID; $3)

vAgentID:=$2

Case of 
	: (Count parameters:C259=3)
		setRequestString($3)
End case 

pickAccounts($1; "selectAccountsForAgent"; $3)
