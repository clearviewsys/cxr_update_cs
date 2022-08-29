//%attributes = {"publishedWeb":true}
C_TEXT:C284($1)
C_TEXT:C284($base)

$base:=Substring:C12($1; 2; 3)  // PARSE THE NAME OF the Currency (BASE)

If ($base="")
	ALL RECORDS:C47([Currencies:6])
Else 
	QUERY:C277([Currencies:6]; [Currencies:6]toISO4217:32=$base)
End if 

QUERY SELECTION:C341([Currencies:6]; [Currencies:6]isHiddenOnWeb:29=False:C215)
ORDER BY:C49([Currencies:6]; [Currencies:6]CurrencyCode:1)
web_SendHTMLPage(->[Currencies:6]; "List")

