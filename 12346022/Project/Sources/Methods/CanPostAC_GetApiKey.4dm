//%attributes = {}
//returns API key for Canada Post address complete
C_TEXT:C284($apiKey; $0)
$apiKey:=getKeyValue("CanadaPost.AddressComplete.api.key")
$0:=$apiKey

