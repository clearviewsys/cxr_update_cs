//%attributes = {}
//returns API key for Canada Post address complete
C_TEXT:C284($apiKey; $0)
$apiKey:=getKeyValue("CanadaPost.AddressComplete.api.key")
$0:=$apiKey

// Keys:
// WH64-KM48-WN53-JM15
// 0a74321adef94b6b : 412325d8f784e810e7e797