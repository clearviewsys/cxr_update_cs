//%attributes = {}


// https://developer.squareup.com/explorer/square/orders-api/retrieve-order

If (False:C215)
	//  curl https://connect.squareupsandbox.com/v2/orders/2gR5HBXv50ZYVNR16p1E2LE7ie4F \
				  -H 'Square-Version: 2022-07-20' \
				  -H 'Authorization: Bearer EAAAELuoASC8neTyvqFwvp1qJKZ00kNgUTullVikbSvBMBCYr9VOG7bkDq0KJpmD' \
				  -H 'Content-Type: application/json'
End if 

If (False:C215)  // returns
	
	//{
	//"order": {
	//"id": "2gR5HBXv50ZYVNR16p1E2LE7ie4F",
	//"location_id": "L0D75FGA57E4A",
	//"line_items": [
	//{
	//"uid": "0GdO3xeRpKwBg3SI3a1drC",
	//"quantity": "1",
	//"name": "sending to you",
	//"base_price_money": {
	//"amount": 56799,
	//"currency": "USD"
	//},
	//"gross_sales_money": {
	//"amount": 56799,
	//"currency": "USD"
	//},
	//"total_tax_money": {
	//"amount": 0,
	//"currency": "USD"
	//},
	//"total_discount_money": {
	//"amount": 0,
	//"currency": "USD"
	//},
	//"total_money": {
	//"amount": 56799,
	//"currency": "USD"
	//},
	//"variation_total_price_money": {
	//"amount": 56799,
	//"currency": "USD"
	//},
	//"item_type": "ITEM"
	//}
	//],
	//"fulfillments": [
	//{
	//"uid": "R788tyTYDmTBOiMh3jiooC",
	//"type": "DIGITAL",
	//"state": "PROPOSED"
	//}
	//],
	//"created_at": "2022-07-20T23:54:48.688Z",
	//"updated_at": "2022-07-21T00:37:13.000Z",
	//"state": "OPEN",
	//"version": 7,
	//"total_tax_money": {
	//"amount": 0,
	//"currency": "USD"
	//},
	//"total_discount_money": {
	//"amount": 0,
	//"currency": "USD"
	//},
	//"total_tip_money": {
	//"amount": 0,
	//"currency": "USD"
	//},
	//"total_money": {
	//"amount": 56799,
	//"currency": "USD"
	//},
	//"tenders": [
	//{
	//"id": "bJaorB4O9TTkFJJcsYmYXGuMnMRZY",
	//"location_id": "L0D75FGA57E4A",
	//"transaction_id": "2gR5HBXv50ZYVNR16p1E2LE7ie4F",
	//"created_at": "2022-07-21T00:37:10Z",
	//"amount_money": {
	//"amount": 56799,
	//"currency": "USD"
	//},
	//"type": "OTHER",
	//"payment_id": "bJaorB4O9TTkFJJcsYmYXGuMnMRZY"    //this is the id to use to look up payment status
	//}
	//],
	//"total_service_charge_money": {
	//"amount": 0,
	//"currency": "USD"
	//},
	//"net_amounts": {
	//"total_money": {
	//"amount": 56799,
	//"currency": "USD"
	//},
	//"tax_money": {
	//"amount": 0,
	//"currency": "USD"
	//},
	//"discount_money": {
	//"amount": 0,
	//"currency": "USD"
	//},
	//"tip_money": {
	//"amount": 0,
	//"currency": "USD"
	//},
	//"service_charge_money": {
	//"amount": 0,
	//"currency": "USD"
	//}
	//},
	//"source": {
	//"name": "Sandbox for sq0idp-Y6-M3levj9dv8Kk66eYT-Q"
	//},
	//"net_amount_due_money": {
	//"amount": 0,
	//"currency": "USD"
	//}
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
	$orderNum:="2gR5HBXv50ZYVNR16p1E2LE7ie4F"  // for testing
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

$stat:=HTTP Get:C1157($url+"orders/"+$orderNum; $response; $atHeaderNames; $atHeaderValues)


Case of 
	: ($stat=200)
		$status.success:=True:C214
		$status.status:=1
		$status.statusText:=$response.order.state  //"SUCCESS"  // STATE: OPEN, COMPLETED, CANCELED
		$status.order:=$response.order
		$status.payment_id:=$response.order.tenders.tenders[0].payment_id
		
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