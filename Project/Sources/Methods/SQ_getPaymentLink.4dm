//%attributes = {}
//https://developer.squareup.com/reference/square/checkout-api/create-payment-link

If (False:C215)  //sample curl call
	//  //curl https://connect.squareupsandbox.com/v2/online-checkout/payment-links \
		  -X POST \
		  -H 'Square-Version: 2022-06-16' \
		  -H 'Authorization: Bearer {ACCESS_TOKEN}' \
		  -H 'Content-Type: application/json' \
		  -d '{
	//"idempotency_key": "{UNIQUE_KEY}",
	//"quick_pay": {
	//   "name": "Auto Detailing",
	//   "price_money": {
	//      "amount": 12500,
	//      "currency": "USD"
	//   },
	//"location_id": "{LOCATION_ID}"
	//}
	//}'
End if 


// square will return
If (False:C215)
	//{
	//"payment_link": {
	//"id": "FWT463MU2JIG7S3D",
	//"version": 1,
	//"order_id": "C0DMgui6YFmgyURVSRtxr4EShheZY",
	//"url": "https://sandbox.square.link/u/jUjglZiR",
	//"created_at": "2022-04-23T18:54:40Z"
	//}
	//}
End if 

C_OBJECT:C1216($1; $request)
C_OBJECT:C1216($0; $return)

C_OBJECT:C1216($response; $params; $oQuickPay)
C_TEXT:C284($currOnErr; $url; $appId; $token; $location)
C_TEXT:C284($baseURL; $context)
C_BOOLEAN:C305($isTesting)
C_LONGINT:C283($elem; $stat)

$currOnErr:=Method called on error:C704
ON ERR CALL:C155("onErrCallIgnore")

$isTesting:=Choose:C955(getKeyValue("web.configuration.payments.square.testmode"; "true")="true"; True:C214; False:C215)

If ($isTesting)
	$url:=getKeyValue("web.configuration.payments.square.test.url"; "https://connect.squareupsandbox.com/v2/")
	$appId:=getKeyValue("web.configuration.payments.square.test.appId"; "sandbox-sq0idb-kLOisDEEMzXMyanFhPlxzQ")
	$location:=getKeyValue("web.configuration.payments.square.test.location"; "L0D75FGA57E4A")
Else 
	$url:=getKeyValue("web.configuration.payments.square.url"; "https://connect.squareup.com/v2/")
	$appId:=getKeyValue("web.configuration.payments.square.appId"; "sandbox-sq0idb-kLOisDEEMzXMyanFhPlxzQ")
	$location:=getKeyValue("web.configuration.payments.square.location"; "L0D75FGA57E4A")
End if 

$baseURL:=getKeyValue("web.configuration.baseURL"; "http://test.lotusfx.com:8082/")
$baseURL:=$baseURL+Choose:C955(Substring:C12($baseURL; Length:C16($baseURL); 1)="/"; ""; "/")
$context:="customers"

$response:=New object:C1471  // init
$return:=New object:C1471("success"; True:C214; "status"; 1; "statusText"; "")  // init for default

// CREATE REQUEST OBJECT
If (Count parameters:C259>=1)
	$params:=$1
	
	$request:=New object:C1471("idempotency_key"; ""; "description"; ""; "source"; "cxr"; "payment_note"; "")
	OB SET:C1220($request; "quick_pay"; New object:C1471("name"; ""; "location_id"; $location; "price_money"; New object:C1471("amount"; 0; "currency"; <>baseCurrency)))
	// quick pay OR order - not both
	//OB SET($request;"order";New object("customer_id";"";"location_id";$location;"reference_id";""))
	OB SET:C1220($request; "checkout_options"; New object:C1471("redirect_url"; ""))
	OB SET:C1220($request; "pre_populated_data"; New object:C1471("buyer_email"; ""; "buyer_phone_number"; ""))
	
	//--------- MAKE SURE THE REQUIRED ELEMENTS ARE INCLUDED -------
	If (True:C214)
		ARRAY TEXT:C222($aProperties; 0)
		OB GET PROPERTY NAMES:C1232($params; $aProperties)
		
		$elem:=Find in array:C230($aProperties; "amount")
		If (Choose:C955($elem=-1; True:C214; False:C215))  //Amount is not in the object
			If ($isTesting)
				$request.quick_pay.price_money.amount:=19900
			Else 
				$return.success:=False:C215
				$return.status:=-1
				$return.statusText:="Missing Amount"
			End if 
		Else 
			$request.quick_pay.price_money.amount:=SQ_utilGetAmount(Num:C11(OB Get:C1224($params; $aProperties{$elem})))
		End if 
		
		$elem:=Find in array:C230($aProperties; "currency")
		If (Choose:C955($elem=-1; True:C214; False:C215))  //CurrencyCode is not in the object
			$request.quick_pay.price_money.currency:=<>baseCurrency  //must match currency of merchant account AUD/NZD
		Else 
			If ($request.quick_pay.price_money.currency#<>baseCurrency)
				TRACE:C157
				$request.quick_pay.price_money.currency:=<>baseCurrency  //must match currency of merchant account AUD/NZD
			Else 
				$request.quick_pay.price_money.currency:=OB Get:C1224($params; $aProperties{$elem})
			End if 
			
		End if 
		
		$elem:=Find in array:C230($aProperties; "name")
		If (Choose:C955($elem=-1; True:C214; False:C215))  // not in the object
			$request.quick_pay.name:="Send money request."
		Else 
			$request.quick_pay.name:=OB Get:C1224($params; $aProperties{$elem})
		End if 
		
		
		$elem:=Find in array:C230($aProperties; "idempotency_key")
		If (Choose:C955($elem=-1; True:C214; False:C215))  // not in the object
			$request.idempotency_key:=[WebEWires:149]WebEwireID:1
		Else 
			$request.idempotency_key:=OB Get:C1224($params; $aProperties{$elem})
		End if 
		
		$elem:=Find in array:C230($aProperties; "description")
		If (Choose:C955($elem=-1; True:C214; False:C215))  // not in the object
			$request.description:=Substring:C12([WebEWires:149]fromParty:7[Info_LastName]+" sends "\
				+String:C10([WebEWires:149]toAmount:10)+" "+[WebEWires:149]toCCY:11+" to "+[WebEWires:149]toParty:8[Info_LastName]\
				+" Via: "+getPaymentTypeFromCode([WebEWires:149]paymentInfo:35.deliveryMethod); 1; 50)
		Else 
			$request.description:=OB Get:C1224($params; $aProperties{$elem})
		End if 
		
		$elem:=Find in array:C230($aProperties; "payment_note")
		If (Choose:C955($elem=-1; True:C214; False:C215))  // not in the object
			$request.payment_note:=$request.description
		Else 
			$request.payment_note:=OB Get:C1224($params; $aProperties{$elem})
		End if 
		
		$elem:=Find in array:C230($aProperties; "buyer_email")
		If (Choose:C955($elem=-1; True:C214; False:C215))  // not in the object
			$request.pre_populated_data.buyer_email:=[WebEWires:149]fromParty:7[Info_Email]
		Else 
			$request.pre_populated_data.buyer_email:=OB Get:C1224($params; $aProperties{$elem})
		End if 
		
		If ($request.pre_populated_data.buyer_email="")
			OB REMOVE:C1226($request.pre_populated_data; "buyer_email")
		End if 
		
		
		$elem:=Find in array:C230($aProperties; "buyer_phone_number")
		If (Choose:C955($elem=-1; True:C214; False:C215))  // not in the object
			$request.pre_populated_data.buyer_phone_number:=[WebEWires:149]fromParty:7[Info_CellPhone]
		Else 
			$request.pre_populated_data.buyer_phone_number:=OB Get:C1224($params; $aProperties{$elem})
		End if 
		
		If ($request.pre_populated_data.buyer_phone_number="")
			OB REMOVE:C1226($request.pre_populated_data; "buyer_phone_number")
		Else 
			Case of 
				: ($request.pre_populated_data.buyer_phone_number="+@")
				: ($request.pre_populated_data.buyer_phone_number="1@")
				Else 
					$request.pre_populated_data.buyer_phone_number:="1"+$request.pre_populated_data.buyer_phone_number
			End case 
			
		End if 
		
		$request.checkout_options.redirect_url:=$baseURL+$context+"/sq-return?reference="+$request.idempotency_key
		
	End if 
	
	
Else   //testing hard coded
	$request:=New object:C1471
	OB SET:C1220($request; "idempotency_key"; String:C10(Current date:C33)+String:C10(Current time:C178))  //required
	OB SET:C1220($request; "description"; "USD to CAD in this amount")
	OB SET:C1220($request; "source"; "CXR")
	
	$oQuickPay:=New object:C1471
	OB SET:C1220($oQuickPay; "name"; "send money request")
	OB SET:C1220($oQuickPay; "location_id"; $location)  // default to web portal
	OB SET:C1220($oQuickPay; "price_money"; New object:C1471("amount"; 12200; "currency"; "USD"))  // no decimal place
	
	OB SET:C1220($request; "quick_pay"; $oQuickPay)  //required
End if 



If ($return.success)
	
	// SET HEADERS
	ARRAY TEXT:C222($atHeaderNames; 0)
	ARRAY TEXT:C222($atHeaderValues; 0)
	SQ_utilSetHeaders(->$atHeaderNames; ->$atHeaderValues)
	
	HTTP SET OPTION:C1160(HTTP timeout:K71:10; 120)
	
	$stat:=HTTP Request:C1158(HTTP POST method:K71:2; $url+"online-checkout/payment-links"; $request; $response; $atHeaderNames; $atHeaderValues)
	
End if 

Case of 
	: ($return.status=-1)  // error with paramters
		WAPI_Log(Current method name:C684; $return.statusText)
		
	: ($stat=200)
		$return.success:=True:C214
		$return.status:=1
		$return.statusText:="SUCCESS"
		$return.url:=$response.payment_link.url
		$return.payment_link:=$response.payment_link
		
	: ($stat=401)  // unauthorized
		$return.success:=False:C215
		$return.status:=$stat
		$return.statusText:="HTTP response status code: "+String:C10($stat)+"  UNAUTHORIZED REQUEST"
		
	Else   //ERROR WITH REQUEST
		$return.success:=False:C215
		$return.status:=$stat
		If ($response.errors[0].field=Null:C1517)
			$return.statusText:=$response.errors[0].detail
		Else 
			$return.statusText:=$response.errors[0].detail+" || "+$response.errors[0].field
		End if 
		
		WAPI_Log(Current method name:C684; $return.statusText)
End case 


$0:=$return

ON ERR CALL:C155($currOnErr)