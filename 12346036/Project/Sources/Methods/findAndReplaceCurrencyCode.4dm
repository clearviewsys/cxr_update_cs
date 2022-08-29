//%attributes = {}
// findAndReplaceCurrencyCode(code1;code2)
// replace all code1 in journal registers to code2

C_TEXT:C284($code1; $code2)
$code1:=Request:C163("Find Currency code")
$code2:=Request:C163("replace with currency code?")

READ WRITE:C146([Registers:10])
QUERY:C277([Registers:10]; [Registers:10]Currency:19=$code1)
APPLY TO SELECTION:C70([Registers:10]; [Registers:10]Currency:19:=$code2)
