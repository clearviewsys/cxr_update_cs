//%attributes = {}
//

// getRate (Country1;Country2) -> real: rate

// url: http://www.xmethods.net/sd/2001/CurrencyExchangeService.wsdl

//


// ----------------------------------------------------------------

C_TEXT:C284($1)
C_TEXT:C284($2)
C_REAL:C285($0)

WEB SERVICE SET PARAMETER:C777("country1"; $1)
WEB SERVICE SET PARAMETER:C777("country2"; $2)

WEB SERVICE CALL:C778("http://services.xmethods.net:80/soap"; ""; "getRate"; "urn:xmethods-CurrencyExchange"; Web Service dynamic:K48:1)

If (OK=1)
	WEB SERVICE GET RESULT:C779($0; "Result"; *)  // Memory clean-up on the final return value.

Else 
	$0:=0
End if 