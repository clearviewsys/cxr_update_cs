//%attributes = {}
C_TEXT:C284($1; $endpoint)  // URL

C_OBJECT:C1216($o; $entity; $record; $status)
C_TEXT:C284($action)




$endpoint:=$1

$action:=WAPI_getParameter("action")

$o:=New object:C1471

$o:=JSON Parse:C1218(WAPI_getParameter("result"))

$entity:=ds:C1482.WebEWires.query("WebEwireID == :1"; $o.purchase_units[0].reference_id)

If ($entity.length=1)
	$record:=$entity.first()
	
	Case of 
		: ($action="approve")
			
			Case of 
				: ($record.status>=10)  //already paid
				: ($record.status<0)  //denied / cancelled
				Else 
					
					$record.paymentInfo.status:=$o.status
					$record.paymentInfo.transactionId:=$o.id
					$record.paymentInfo.transactionDateTime:=$o.create_time
					$record.paymentInfo.paymentMethod:="PAYPAL"
					
					If ($record.paymentInfo.paymentData=Null:C1517)
						$record.paymentInfo.paymentData:=New object:C1471
					End if 
					
					$record.paymentInfo.paymentData:=$o
					
					If ($record.status<10) & ($record.status>=0)
						$record.status:=10
					End if 
					
					$record.AML_Info[AML_fromMOPCode]:=getKeyValue("web.customers.webewires.frommop.paypal")
					
					Case of 
						: ($record.paymentInfo.status="COMPLETED")  // The payment was authorized or the 
							// authorized payment was captured for the order.
							$record.status:=10
						: ($record.paymentInfo.status="APPROVED")  //The customer approved the payment through 
							// the PayPal wallet or another form of guest or unbranded payment. 
							$record.status:=10
						: ($record.paymentInfo.status="CREATED")  // order created with the specified context
							$record.status:=5
						: ($record.paymentInfo.status="SAVED")
							//The order was saved and persisted. 
							// The order status continues to be in progress until a capture is made with 
							// final_capture = true for all purchase units within the order.
							$record.status:=5
						: ($record.paymentInfo.status="VOIDED")  //All purchase units in the order are voided.
							$record.status:=-10  //cancel - customer didn't finish in time
							$record.isCancelled:=True:C214
						: ($record.paymentInfo.status="PAYER_ACTION_REQUIRED")
							//The order requires an action from the payer (e.g. 3DS authentication). 
							// Redirect the payer to the "rel":"payer-action" HATEOAS link returned as part of 
							// the response prior to authorizing or capturing the order.
							$record.status:=5
							
					End case 
					
					$status:=$record.save()
					If ($status.success)
					Else 
						
					End if 
					
					
			End case 
			
			WAPI_pushDOMVisible("paypal-button-container"; False:C215)
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