//%attributes = {}
C_BOOLEAN:C305($result)
ws_addDemoRecord("tiran"; "123456."; UTIL_getMacAddress)
$result:=ws_updateMacAddress("tiran"; "123456."; UTIL_getMacAddress; "Demo"; "Computer "; String:C10(Current date:C33))  // Jan 16, 2012 06:47:00 -- I.Barclay Berry added String()
