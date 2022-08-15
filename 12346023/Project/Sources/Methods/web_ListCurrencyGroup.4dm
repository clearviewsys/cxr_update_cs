//%attributes = {"publishedWeb":true}
C_TEXT:C284($1; $base)

$base:=Substring:C12($1; 2)  // PARSE THE NAME OF the GROUP

If ($base="")
	ALL RECORDS:C47([Currencies:6])
Else 
	QUERY:C277([Currencies:6]; [Currencies:6]CurrencyGroup:34=$base)
End if 

QUERY SELECTION:C341([Currencies:6]; [Currencies:6]isHiddenOnWeb:29=False:C215)
ORDER BY:C49([Currencies:6]; [Currencies:6]CurrencyCode:1)
web_SendHTMLPage(->[Currencies:6]; "List")

