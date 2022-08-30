//%attributes = {}
// webListSelectedTable(->[table];->[sortField];ascending:boolean)

C_POINTER:C301($1; $2)
C_BOOLEAN:C305($3)

C_TEXT:C284(webLoginID)
If (webisContextAlive(webContextID))
	QUERY SELECTION:C341([Links:17]; [Links:17]AuthorizedUser:13=webLoginID)  // select self created links only
	
	If ($3)  // ascending
		
		ORDER BY:C49($1->; $2->; >)
	Else   // descending
		
		ORDER BY:C49($1->; $2->; <)
	End if 
	web_SendHTMLPage($1; "List"; "*")
Else 
	web_SendContextExpiredPage
End if 
