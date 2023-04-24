//%attributes = {}


//https://developer.squareup.com/reference/square/payments-api/get-payment

If (False:C215)
	// curl https://connect.squareupsandbox.com/v2/payments/bJaorB4O9TTkFJJcsYmYXGuMnMRZY \
				  -H 'Square-Version: 2022-07-20' \
				  -H 'Authorization: Bearer EAAAELuoASC8neTyvqFwvp1qJKZ00kNgUTullVikbSvBMBCYr9VOG7bkDq0KJpmD' \
				  -H 'Content-Type: application/json'
End if 

If (False:C215)  // returns
	
	//{
	//"payment": {
	//"id": "bJaorB4O9TTkFJJcsYmYXGuMnMRZY",
	//"created_at": "2022-07-21T00:37:10.589Z",
	//"amount_money": {
	//"amount": 56799,
	//"currency": "USD"
	//},
	//"status": "COMPLETED",
	//"source_type": "EXTERNAL",
	//"location_id": "L0D75FGA57E4A",
	//"order_id": "2gR5HBXv50ZYVNR16p1E2LE7ie4F",
	//"total_money": {
	//"amount": 56799,
	//"currency": "USD"
	//},
	//"capabilities": [
	//"EDIT_AMOUNT_UP",
	//"EDIT_AMOUNT_DOWN",
	//"EDIT_TIP_AMOUNT_UP",
	//"EDIT_TIP_AMOUNT_DOWN"
	//],
	//"external_details": {
	//"type": "CARD",
	//"source": "Developer Control Panel"
	//},
	//"receipt_number": "bJao",
	//"receipt_url": "https://squareupsandbox.com/receipt/preview/bJaorB4O9TTkFJJcsYmYXGuMnMRZY",
	//"application_details": {
	//"square_product": "ECOMMERCE_API",
	//"application_id": "sandbox-sq0idb-lky4CaPAWmDnHY3YtYxINg"
	//},
	//"version_token": "Fmu6RQz3tdinHFw7ej5VwH0i1wq05SUjqscgGrTPPKL6o"
	//}
	//}
	
	// STATUS: APPROVED, PENDING, COMPLETED, CANCELED, or FAILED
End if 

C_TEXT:C284($1; $orderNum)  // payment_link.id

C_OBJECT:C1216($0; $status)

C_OBJECT:C1216($response)
C_TEXT:C284($url)
C_LONGINT:C283($stat)


If (Count parameters:C259>=1)
	$orderNum:=$1
Else 
	$orderNum:="bJaorB4O9TTkFJJcsYmYXGuMnMRZY"  // for testing
End if 

$status:=New object:C1471("success"; True:C214; "status"; 0; "statusText"; "")


If (Choose:C955(getKeyValue("web.configuration.payments.square.testmode"; "true")="true"; True:C214; False:C215))
	$url:=getKeyValue("web.configuration.payments.square.test.url"; "https://connect.squareupsandbox.com/v2/")
Else 
	$url:=getKeyValue("web.configuration.payments.square.url"; "https://connect.squareup.com/v2/")
End if 


// SET HEADERS
ARRAY TEXT:C222($atHeaderNames; 0)
ARRAY TEXT:C222($atHeaderValues; 0)
SQ_utilSetHeaders(->$atHeaderNames; ->$atHeaderValues)

HTTP SET OPTION:C1160(HTTP timeout:K71:10; 120)

$stat:=HTTP Get:C1157($url+"payments/"+$orderNum; $response; $atHeaderNames; $atHeaderValues)


Case of 
	: ($stat=200)
		$status.success:=True:C214
		$status.status:=1
		$status.statusText:=$response.payment.status  //"SUCCESS"  // STATUS: APPROVED, PENDING, COMPLETED, CANCELED, or FAILED
		$status.payment:=$response.payment
		
	: ($stat=401)  // not authorized
		$status.success:=False:C215
		$status.status:=$stat
		$status.statusText:="NOT AUTHORIZED"
	Else 
		$status.success:=False:C215
		$status.status:=$stat
		$status.statusText:=$response.errors[0].details
End case 

$0:=$status