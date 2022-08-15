//%attributes = {}

WAPI_sendFile("/login/confirmEmailToken.shtml"; WAPI_getSession("context"))


//$tPageName:=WAPI_getSendPage ("confirmEmailTokenPage")
//If ($tPageName="")
//$tPageName:=webContext+"/login/confirmEmailToken.shtml"
//End if 
//
//WEB SEND HTTP REDIRECT($tPageName)

//WEB SEND FILE("confirmEmailToken.shtml")
