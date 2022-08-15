//%attributes = {}

LogUserLoggingOut(String:C10(getApplicationUser); getCurrentMachineName)

//If (getKeyValue ("feature.hola";"false")="true")
iH_unregisterClient
//End if 

<>SystemUser:=Current user:C182

//<>ApplicationUser:="LOCKED"
setApplicationUser("LOCKED")

<>UserID:=""
POST OUTSIDE CALL:C329(-1)
