//%attributes = {}
//author: Amir
//test method for getCurrencyRatesAtDate
C_BOOLEAN:C305($success)
C_DATE:C307($date)
ARRAY TEXT:C222($arrCurrencyCodes; 0)
ARRAY REAL:C219($arrCurrencyRates; 0)

$date:=Date:C102("2020-03-12T00:00:00.0000")
$success:=getCurrencyRatesAtDate($date; ->$arrCurrencyCodes; ->$arrCurrencyRates)
ASSERT:C1129($success=True:C214; "Expected true for success")
ASSERT:C1129(Size of array:C274($arrCurrencyCodes)=207; "Expectation failed for size of result")
ASSERT:C1129(Size of array:C274($arrCurrencyRates)=207; "Expectation failed for size of result")
ASSERT:C1129($arrCurrencyCodes{1}="AED"; "Expectation failed for first currency code")
ASSERT:C1129($arrCurrencyRates{1}=0.443203203855; "Expectation failed for first currency rate")