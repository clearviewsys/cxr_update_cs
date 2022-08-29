//%attributes = {}

If (False:C215)
	//{
	//"merchant_id": "6SSW7HV8K2ST5",
	//"type": "payment.created",
	//"event_id": "13b867cf-db3d-4b1c-90b6-2f32a9d78124",
	//"created_at": "2020-02-06T21:27:30.792Z",
	//"data": {
	//"type": "payment",
	//"id": "KkAkhdMsgzn59SM8A89WgKwekxLZY",
	//"object": {
	//"payment": {
	//"id": "hYy9pRFVxpDsO1FB05SunFWUe9JZY",
	//"created_at": "2020-11-22T21:16:51.086Z",
	//"updated_at": "2020-11-22T21:16:51.198Z",
	//"amount_money": {
	//"amount": 100,
	//"currency": "USD"
	//},
	//"status": "APPROVED",
	//"delay_duration": "PT168H",
	//"source_type": "CARD",
	//"card_details": {
	//"status": "AUTHORIZED",
	//"card": {
	//"card_brand": "MASTERCARD",
	//"last_4": "9029",
	//"exp_month": 11,
	//"exp_year": 2022,
	//"fingerprint": "sq-1-Tvruf3vPQxlvI6n0IcKYfBukrcv6IqWr8UyBdViWXU2yzGn5VMJvrsHMKpINMhPmVg",
	//"card_type": "CREDIT",
	//"prepaid_type": "NOT_PREPAID",
	//"bin": "540988"
	//},
	//"entry_method": "KEYED",
	//"cvv_status": "CVV_ACCEPTED",
	//"avs_status": "AVS_ACCEPTED",
	//"statement_description": "SQ *DEFAULT TEST ACCOUNT",
	//"card_payment_timeline": {
	//"authorized_at": "2020-11-22T21:16:51.198Z"
	//}
	//},
	//"location_id": "S8GWD5R9QB376",
	//"order_id": "03O3USaPaAaFnI6kkwB1JxGgBsUZY",
	//"risk_evaluation": {
	//"created_at": "2020-11-22T21:16:51.198Z",
	//"risk_level": "NORMAL"
	//},
	//"total_money": {
	//"amount": 100,
	//"currency": "USD"
	//},
	//"approved_money": {
	//"amount": 100,
	//"currency": "USD"
	//},
	//"capabilities": [
	//"EDIT_TIP_AMOUNT",
	//"EDIT_TIP_AMOUNT_UP",
	//"EDIT_TIP_AMOUNT_DOWN"
	//],
	//"receipt_number": "hYy9",
	//"delay_action": "CANCEL",
	//"delayed_until": "2020-11-29T21:16:51.086Z",
	//"version_token": "FfQhQJf9r3VSQIgyWBk1oqhIwiznLwVwJbVVA0bdyEv6o"
	//}
	//}
	//}
	//}
	
End if 


C_TEXT:C284($1; $endpoint)  // URL


C_TEXT:C284($paymentId; $orderId; $paymentStatus)
C_OBJECT:C1216($o; $entity; $record; $status)
C_TEXT:C284($action)




$endpoint:=$1

$o:=New object:C1471

$o:=JSON Parse:C1218(WAPI_getParameter("result"))

$paymentId:=$o.data.object.payment.id
$orderId:=$o.data.object.payment.order_id
$paymentStatus:=$o.data.object.payment.status  //APPROVED, PENDING, COMPLETED, CANCELED, or FAILED.


$entity:=ds:C1482.WebEWires.query("paymentInfo.paymentMethod == :1 AND paymentInfo.transactionRefNo"; "SQ"; $orderId)

If ($entity.length=1)
	$record:=$entity.first()
	
	Case of 
		: ($paymentStatus="APPROVED") | ($paymentStatus="COMPLETED")  // WHAT IS THE DIFF?
			
			Case of 
				: ($record.status>=10)  //already paid
				: ($record.status<0)  //denied / cancelled
				Else 
					
					$record.paymentInfo.status:=$o.status
					$record.paymentInfo.transactionId:=$o.id
					$record.paymentInfo.transactionDateTime:=$o.create_time
					$record.paymentInfo.paymentMethod:="SQ"
					
					If ($record.paymentInfo.paymentData=Null:C1517)
						$record.paymentInfo.paymentData:=New object:C1471
					End if 
					
					$record.paymentInfo.paymentData:=$o
					
					If ($record.status<10) & ($record.status>=0)
						$record.status:=10
					End if 
					
					$record.AML_Info[AML_fromMOPCode]:=getKeyValue("web.customers.webewires.frommop.sq")
					
					Case of 
						: ($record.paymentInfo.status="COMPLETED")  // The payment was authorized or the 
							// authorized payment was captured for the order.
							$record.status:=10
						: ($record.paymentInfo.status="APPROVED")  //The customer approved the payment through 
							// the PayPal wallet or another form of guest or unbranded payment. 
							$record.status:=10
						: ($record.paymentInfo.status="PENDING")  // order created with the specified context
							$record.status:=5
						: ($record.paymentInfo.status="CANCELED")  //All purchase units in the order are voided.
							$record.status:=-10  //cancel - customer didn't finish in time
							$record.isCancelled:=True:C214
						: ($record.paymentInfo.status="FAILED")  //
							$record.status:=-20  //
							$record.isCancelled:=True:C214
							
					End case 
					
					$status:=$record.save()
					If ($status.success)
					Else 
						
					End if 
					
					
			End case 
			
			//WAPI_pushDOMVisible ("paypal-button-container";False)
			WAPI_pushDisplayMessage("APPROVED"; "Thank you for your payment.")
			
			
		: ($action="cancel")
			WAPI_pushDisplayMessage("CANCELLED"; WAPI_getParameter("result"))
			
			
		: ($action="error")
			WAPI_pushDisplayMessage("ERROR"; WAPI_getParameter("result"))
			
			
		Else 
			
	End case 
	
Else 
	
	WAPI_pushDisplayMessage("REQUEST NOT FOUND"; "")
End if 


WEB SEND TEXT:C677(WAPI_pullJsStack)