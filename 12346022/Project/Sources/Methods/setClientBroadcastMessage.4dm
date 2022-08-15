//%attributes = {}

// setBroadcastMessage (text)
// this method will publish the broadcase message to registrationserver keyvalue database

C_TEXT:C284($message; $1)
$message:=$1
ws_setKeyValueAsText(<>clientCode; <>clientKey; "dispatchMessage"; $message)
