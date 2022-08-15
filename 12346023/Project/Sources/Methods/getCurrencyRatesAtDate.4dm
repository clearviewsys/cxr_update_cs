//%attributes = {}
//author: Amir
//7th Feb 2019
//this method returns the historical currency exchange rates, at given date
//getCurrencyRatesAtDate(
//$date:date->date to find the rates at
//$arrCurrencyCodesPtr->pointer to array of text to store currency codes
//$arrCurrencyRatesPtr->pointer to array of real to store currency rates
//)
//returns false in case of error, true for success
C_BOOLEAN:C305($success; $0)
C_DATE:C307($date; $1)
C_POINTER:C301($arrCurrencyCodesPtr; $2)
C_POINTER:C301($arrCurrencyRatesPtr; $3)


$date:=$1
$arrCurrencyCodesPtr:=$2
$arrCurrencyRatesPtr:=$3

ASSERT:C1129(Type:C295($date)=Is date:K8:7; "Expected date for first argument")
ASSERT:C1129(Type:C295($arrCurrencyCodesPtr)=Is pointer:K8:14; "Expected pointer to array of text to store currency codes")
ASSERT:C1129(Type:C295($arrCurrencyCodesPtr->)=Text array:K8:16; "Expected pointer to array of text to store currency codes")
ASSERT:C1129(Type:C295($arrCurrencyRatesPtr)=Is pointer:K8:14; "Expected pointer to array of real to store currency rates")
ASSERT:C1129(Type:C295($arrCurrencyRatesPtr->)=Real array:K8:17; "Expected pointer to array of real to store currency rates")

If (Count parameters:C259#3)
	assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End if 
C_TEXT:C284($url; $domain)

$domain:="https://cloud.clearviewsys.net/cxrate/json/"
C_TEXT:C284($formattedDate)
$formattedDate:=String:C10(Year of:C25($date))+"-"+String:C10(Month of:C24($date))+"-"+String:C10(Day of:C23($date))

C_TEXT:C284($encodedClientKey)
C_TEXT:C284($encodedClientCode)

$encodedClientKey:=replaceUnsafeURLCharacters(<>CLIENTKEY2)
$encodedClientCode:=replaceUnsafeURLCharacters(<>CLIENTCODE2)

$url:=$domain+"getHistoricalRateTable?"+"clientcode="+$encodedClientCode+"&clientkey="+$encodedClientKey+"&date="+$formattedDate+"&basecurrency="+<>BASECURRENCY

C_TEXT:C284($response; $content)
C_LONGINT:C283($httpStatus)

HTTP SET OPTION:C1160(HTTP timeout:K71:10; 10)  //time out in 10 seconds
setErrorTrap(Current method name:C684; "Error connecting to CXRate cloud service.")
$httpStatus:=HTTP Request:C1158(HTTP GET method:K71:1; $url; $content; $response)
endErrorTrap

If (($response#"null") & ($response#"") & ($httpStatus=200))
	ARRAY OBJECT:C1221($arrCurrencyRecords; 0)
	JSON PARSE ARRAY:C1219($response; $arrCurrencyRecords)
	C_LONGINT:C283($numResults; $index)
	$numResults:=Size of array:C274($arrCurrencyRecords)
	For ($index; 1; $numResults)
		If (Not:C34(Undefined:C82($arrCurrencyRecords{$index}.CurrencyCode)))
			APPEND TO ARRAY:C911($arrCurrencyCodesPtr->; $arrCurrencyRecords{$index}.CurrencyCode)
		End if 
		If (Not:C34(Undefined:C82($arrCurrencyRecords{$index}.MarketRate)))
			APPEND TO ARRAY:C911($arrCurrencyRatesPtr->; Num:C11($arrCurrencyRecords{$index}.MarketRate))
		End if 
	End for 
	
	$success:=True:C214
Else 
	$success:=False:C215
End if 

$0:=$success







