//%attributes = {}
//author: Amir
//date: 10th Feb 2019
//finds all currency codes, and populates the input array
//does not alter the current selection of [Currencies] table
//getAllCurrencyCodes(
//->arrCurrency: pointer to text array to fill with currency codes
//)
C_POINTER:C301($1; $arrCurrencyCodesPtr)
ASSERT:C1129(Count parameters:C259=1; "Expected one pointer to a text array")
$arrCurrencyCodesPtr:=$1

//preserve current selection of currency table
COPY NAMED SELECTION:C331([Currencies:6]; "previousSelection")

READ ONLY:C145([Currencies:6])
ALL RECORDS:C47([Currencies:6])
ORDER BY:C49([Currencies:6]; [Currencies:6]CurrencyCode:1; <)
DISTINCT VALUES:C339([Currencies:6]CurrencyCode:1; $arrCurrencyCodesPtr->)

USE NAMED SELECTION:C332("previousSelection")
CLEAR NAMED SELECTION:C333("previousSelection")
