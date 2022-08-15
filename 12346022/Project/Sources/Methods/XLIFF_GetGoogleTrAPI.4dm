//%attributes = {}
// --------------------------------------------------------------
// Method XLIFF_GetGoogleTrAPI: 
// Makes a web request to get the translation using Google API
// Parameters: (none)
// -------------------------------------------------------------


// Request XML to external web server
C_LONGINT:C283(gError; $httpStatusCode)

gError:=0
ON ERR CALL:C155("getXMLError")
// Request XML to external web server 
$httpStatusCode:=HTTP Get:C1157(url; textData; attrNames; attrValues)
ON ERR CALL:C155("")
$0:=$httpStatusCode


