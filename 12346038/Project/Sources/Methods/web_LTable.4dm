//%attributes = {}
// webLTable(->table;URLstring;HTMLPage;{{->relateOneField};{ ->relateOneField2}})

// this method must be called when the view form needs a context Id 

// for example see webLSendeWire


C_TEXT:C284($2; $3)
C_POINTER:C301($1; $4; $5)

C_TEXT:C284(searchKey; webContextID)
web_ParseURL($2; ->webContextID; ->searchKey)

QUERY:C277($1->; Field:C253(Table:C252($1); 1)->=searchKey)

Case of 
	: (Count parameters:C259=4)
		RELATE ONE:C42($4->)
	: (Count parameters:C259=5)
		RELATE ONE:C42($4->)
		RELATE ONE:C42($5->)
End case 

SetVariablesToFields($1)

If (webisContextAlive(webContextID))
	WEB SEND FILE:C619($3)
Else 
	web_SendContextExpiredPage
End if 