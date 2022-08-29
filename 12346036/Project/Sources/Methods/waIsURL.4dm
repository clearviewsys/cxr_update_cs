//%attributes = {}
// checks if part of URL is present in WebArea currently displayed URL

C_TEXT:C284($1; $wa)
C_TEXT:C284($2; $urlToCheck)
C_TEXT:C284($currURL)
C_BOOLEAN:C305($0)

$wa:=$1
$urlToCheck:=$2
$0:=False:C215

$currURL:=WA Get current URL:C1025(*; $wa)

If (Position:C15($urlToCheck; $currURL)>0)
	$0:=True:C214
End if 
