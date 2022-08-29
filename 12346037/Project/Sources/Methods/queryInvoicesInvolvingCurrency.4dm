//%attributes = {}
// queryInvolvingCurrency( currencyCode)
// queries all the invoices that have the currency in their buy or sell

C_TEXT:C284($1)

QUERY:C277([Invoices:5]; [Invoices:5]fromCurrency:3=$1; *)
QUERY:C277([Invoices:5];  | ; [Invoices:5]toCurrency:8=$1)
