//%attributes = {}
// @viktor 15/01/2021
// Unit test is written @Viktor
C_OBJECT:C1216($response)
C_TEXT:C284($1)
C_TEXT:C284($IBAN; $APIKEY; $url)
C_POINTER:C301($2; $3; $4; $5; $6; $7; $8)
C_POINTER:C301($errorCode; $bankName; $countryCode; $city; $address; $swift; $validCheckSum)
C_LONGINT:C283($httpStatus)

$IBAN:=Replace string:C233($1; " "; "")  // Get rid of Spaces in IBAN to prevent errors in Http request
$errorCode:=$2
$bankName:=$3
$countryCode:=$4
$city:=$5
$address:=$6
$swift:=$7
$validCheckSum:=$8

$APIKEY:="ceef5524cecb23cb780ab0a6bd937195"
$url:="https://api.iban.com/clients/api/v4/iban/?api_key="+$APIKEY+"&format=json&iban="+$IBAN+""
gError:=0
ON ERR CALL:C155("getJSONError")
$httpStatus:=HTTP Get:C1157($url; $response)
ON ERR CALL:C155("")

If ($httpStatus=200)
	$IBAN:=Replace string:C233($1; " "; "")  // Get rid of Spaces in IBAN
	
	$bankName->:=""
	$countryCode->:=""
	$city->:=""
	$address->:=""
	$swift->:=""
	$validCheckSum->:=""
	$errorCode->:=""
	
	If (OB Is defined:C1231($response;"bank_data"))
		If (OB Is defined($response;"bank"))
			$bankName->:=$response.bank_data.bank
		End if 
		If (OB Is defined:C1231($response;"country_iso"))
			$countryCode->:=$response.bank_data.country_iso
		End if 
		If (OB Is defined:C1231($response;"city"))
			$city->:=$response.bank_data.city
		End if 
		If (OB Is defined:C1231($response;"address"))
			$address->:=$response.bank_data.address
		End if 
		If (OB Is defined:C1231($response;"bic"))
			$swift->:=$response.bank_data.bic
		End if 
	End if 

	If (OB Is defined:C1231($response;"validations"))
		If (OB Is defined:C1231($response.validations;"account"))
			If (OB Is defined:C1231($response.validations.account;"message"))
				$validCheckSum->:=$response.validations.account.message
			End if 
		End if 
	End if 
	
	// Parse error message
	C_LONGINT:C283($errNum)
	$errNum:=1
	
	// CHARS
	If (Num:C11($response.validations.chars.code)>100)
		$errorCode->:=$errorCode->+" "+String:C10($errNum)+". "+$response.validations.chars.message+"."
		$errNum:=$errNum+1
	End if 
	// IBAN
	If (Num:C11($response.validations.iban.code)>100)
		$errorCode->:=$errorCode->+" "+String:C10($errNum)+". "+$response.validations.iban.message+"."
		$errNum:=$errNum+1
	End if 
	// ACCOUNT
	If (Num:C11($response.validations.account.code)>100)
		$errorCode->:=$errorCode->+" "+String:C10($errNum)+". "+$response.validations.account.message+"."
		$errNum:=$errNum+1
	End if 
	// STRUCTURE
	If (Num:C11($response.validations.structure.code)>100)
		$errorCode->:=$errorCode->+" "+String:C10($errNum)+". "+$response.validations.structure.message+"."
		$errNum:=$errNum+1
	End if 
	// LENGTH
	If (Num:C11($response.validations.length.code)>100)
		$errorCode->:=$errorCode->+" "+String:C10($errNum)+". "+$response.validations.length.message+"."
		$errNum:=$errNum+1
	End if 
	// COUNTRY SUPPORT
	If (Num:C11($response.validations.country_support.code)>100)
		$errorCode->:=$errorCode->+" "+String:C10($errNum)+". "+$response.validations.country_support.message+"."
		$errNum:=$errNum+1
	End if 
	
Else 
	$errorCode->:="IBAN Web Service not available, try again. Url: "+$url+". Error code: "+String:C10(gError)
End if 