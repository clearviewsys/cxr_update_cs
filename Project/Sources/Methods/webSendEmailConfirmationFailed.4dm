//%attributes = {}

//WEB SEND FILE("emailConfirmationFailed.shtml")

WAPI_sendFile("/login/confirmEmailToken.shtml"; WAPI_getSession("context"))