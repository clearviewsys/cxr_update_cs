C_TEXT:C284($group)

$group:=Request:C163("Please enter the group name?")

READ WRITE:C146([Currencies:6])
USE SET:C118("$currencies_LBSet")

APPLY TO SELECTION:C70([Currencies:6]; [Currencies:6]CurrencyGroup:34:=$group)
READ ONLY:C145([Currencies:6])
