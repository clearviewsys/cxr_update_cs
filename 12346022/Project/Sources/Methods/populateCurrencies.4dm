//%attributes = {}
// populateCurrencies

// ([flags];"Listbox")

ARRAY TEXT:C222($arrCodes; 0)
ARRAY TEXT:C222($arrflags; 0)

ALL RECORDS:C47([Flags:19])
SELECTION TO ARRAY:C260([Flags:19]CurrencyCode:1; $arrCodes; [Flags:19]CurrencyName:2; $arrflags)

populateCurrencyArrays(->$arrCodes; ->$arrflags)

ARRAY TO SELECTION:C261($arrCodes; [Flags:19]CurrencyCode:1; $arrflags; [Flags:19]CurrencyName:2)
UNLOAD RECORD:C212([Flags:19])

READ ONLY:C145([Flags:19])

allrecordsFlags