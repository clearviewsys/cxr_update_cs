//%attributes = {"publishedWeb":true}
// webSendErrorPage 

C_POINTER:C301($1)

//SEND HTML TEXT(checkGetErrorString )
webErrorString:=checkGetErrorString
WEB SEND FILE:C619("errorPage.html")