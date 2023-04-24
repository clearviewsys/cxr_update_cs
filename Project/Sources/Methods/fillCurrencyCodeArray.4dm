//%attributes = {}
// fillCurrencyCodeArray (->array)


C_POINTER:C301($1)

QUERY:C277([Currencies:6]; [Currencies:6]isDisplayOnly:33=False:C215)
ORDER BY:C49([Currencies:6]; [Currencies:6]CurrencyCode:1)
SELECTION TO ARRAY:C260([Currencies:6]CurrencyCode:1; $1->)