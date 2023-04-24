//%attributes = {"shared":true}
myAlert("This computer MAC address is "+UTIL_getMacAddress)
CONFIRM:C162("Copy to Clipboard?")
If (OK=1)
	SET TEXT TO PASTEBOARD:C523(UTIL_getMacAddress)
End if 