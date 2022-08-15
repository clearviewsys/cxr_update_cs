//%attributes = {"shared":true}
C_POINTER:C301($1)

selectFavoriteCurrencies

C_LONGINT:C283($winRef)
$winRef:=Open form window:C675([Currencies:6]; "CurrenciesPanel"; Plain window:K34:13; On the right:K39:3; At the top:K39:5; *)
FORM SET OUTPUT:C54([Currencies:6]; "CurrenciesPanel")
READ ONLY:C145([Currencies:6])
DISPLAY SELECTION:C59([Currencies:6]; *)
CLOSE WINDOW:C154

