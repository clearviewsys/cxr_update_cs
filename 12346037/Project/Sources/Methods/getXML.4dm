//%attributes = {}
// ----------------------------------------------------
// getXML: Makes a web request to get the XML File
// Parameters: (none)
// ----------------------------------------------------


// Request XML to external web server
C_LONGINT:C283(gError; $response; $0)
C_TEXT:C284(xmlData)

gError:=0
ON ERR CALL:C155("getXMLError")

// Request XML to external web server 
$response:=HTTP Get:C1157(url; xmlData; attrNames; attrValues)
ON ERR CALL:C155("")
$0:=gError



