//%attributes = {}
// ws_getConversionRate_S3

C_LONGINT:C283($error; $0)
C_TEXT:C284($fromCurrency; $toCurrency; $1; $2)
C_POINTER:C301($ratePtr; $3)
C_LONGINT:C283($iTries)

$fromCurrency:=$1
$toCurrency:=$2
$ratePtr:=$3

C_TEXT:C284($url; $domain; $tOpenExchangerAppID)
$tOpenExchangerAppID:=getKeyValue("currency.rate.source.openexchangerate.appID")
If ($tOpenExchangerAppID#"")
	// Reference: Default CXR appID 551e6b5c70db4bddbeaa25df8f4d8146
	// also this keyvalue must be turn ON for the open exchanger to work currency.rate.source.openexchangerates="true"
	
	$domain:="https://openexchangerates.org/api/latest.json?app_id="+$tOpenExchangerAppID
	
	$url:=$domain+"&base="+$fromCurrency+"&symbols="+$toCurrency
	C_OBJECT:C1216($response; $content)
	C_LONGINT:C283($httpStatus)
	
	HTTP SET OPTION:C1160(HTTP timeout:K71:10; <>webTimeOut)  //time out in 5 seconds
	setErrorTrap(Current method name:C684; "Error connecting to CXRate OpenExchangerRate.")
	
	$iTries:=0
	Repeat 
		$iTries:=$iTries+1
		
		$httpStatus:=HTTP Request:C1158(HTTP GET method:K71:1; $url; $content; $response)
		
		If ($httpStatus=200)
		Else 
			DELAY PROCESS:C323(Current process:C322; 10)
		End if 
		
	Until (($httpStatus=200) | ($iTries>=5))
	
	If (($response.rates#Null:C1517) & ($httpStatus=200))
		$ratePtr->:=Num:C11(OB Get:C1224($response.rates; $toCurrency))
	Else 
		$error:=1
	End if 
Else 
	setErrorTrap(Current method name:C684; "Error connecting to CXRate OpenExchangerRate. Certain key value is missing, please contact support.")
	$error:=1
End if 

$0:=$error
endErrorTrap
