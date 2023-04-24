//%attributes = {}
//Developer Url
setKeyValue("currencyCloud.URL"; "https://devapi.currencycloud.com/v2")
//Live URL
//setKeyValue ("currencyCloud.URL";"https://api.currencycloud.com/v2")

C_TEXT:C284($URL)
If (UTIL_isMethodExists("getKeyValue"))
	
	
	EXECUTE METHOD:C1007("getKeyValue"; $URL; "currencyCloud.URL")
End if 

$URL:=CC_getURL
$URL:=CC_getUrlKeyValue
$URl:=getKeyValue("currencyCloud.URL")
myAlert($URL)