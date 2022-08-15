//%attributes = {}


C_TEXT:C284($0; $status)

C_OBJECT:C1216($return)
C_BOOLEAN:C305($readOnlyStatus)
C_TEXT:C284($gateway)
C_LONGINT:C283($iCount; $i)

$status:="UNDEFINED"
$gateway:=""

If (OB Is defined:C1231([WebEWires:149]paymentInfo:35))
	If (OB Get type:C1230([WebEWires:149]paymentInfo:35; "gateway")=Is undefined:K8:13)  //check for gateway
		If (OB Get type:C1230([WebEWires:149]paymentInfo:35; "poliLink")#Is undefined:K8:13)  //test for "Old" transaction with out gateway info
			$gateway:="polipaylink"
		End if 
	Else 
		$gateway:=[WebEWires:149]paymentInfo:35.gateway
	End if 
	
	Case of 
		: ([WebEWires:149]status:16>=10)  //don't bother to check - already paid
			//$status:=[WebEWires]paymentInfo.status
			
			If (OB Get type:C1230([WebEWires:149]paymentInfo:35; "status")=Is undefined:K8:13)
				$status:="UNDEFINED"
			Else 
				$status:=OB Get:C1224([WebEWires:149]paymentInfo:35; "status"; Is text:K8:3)
			End if 
			
			
		: ([WebEWires:149]status:16<0)  //don't bother to check - denied or cancelled
			$status:=OB Get:C1224([WebEWires:149]paymentInfo:35; "status"; Is text:K8:3)
			
		: ($gateway="polipaylink")
			Case of 
				: ([WebEWires:149]status:16>=10)  //don't bother to check - already paid
					$status:=[WebEWires:149]paymentInfo:35.status
				: ([WebEWires:149]status:16<0)  //don't bother to check - denied or cancelled
					$status:=[WebEWires:149]paymentInfo:35.status
				: ([WebEWires:149]paymentInfo:35.poliLink#"")  //configured for poliLink payment
					$return:=POLI_getPaymentDetails([WebEWires:149]paymentInfo:35.poliLink)
					If ($return.success)
						$status:=$return.statusText
						
						$readOnlyStatus:=Read only state:C362([WebEWires:149])
						READ WRITE:C146([WebEWires:149])
						Repeat 
							LOAD RECORD:C52([WebEWires:149])
						Until (Not:C34(Locked:C147([WebEWires:149])))
						
						OBJ_newPaymentInfo(->[WebEWires:149]paymentInfo:35)
						[WebEWires:149]paymentInfo:35.status:=$status
						
						
						Case of 
							: ($status="Completed")
								//if multiple need to find correct transaction
								C_OBJECT:C1216($transaction)
								$iCount:=$return.history.length
								
								If ($iCount>0)
									For each ($transaction; $return.history)
										If ($transaction.Status="Completed")
											[WebEWires:149]paymentInfo:35.transactionRefNo:=$transaction.TransactionRefNo
											[WebEWires:149]paymentInfo:35.amountPaid:=$transaction.AmountPaid
										End if 
									End for each 
								End if 
								
								If ([WebEWires:149]status:16<10) & ([WebEWires:149]status:16>=0)
									[WebEWires:149]status:16:=10
								End if 
								
								OB SET:C1220([WebEWires:149]AML_Info:9; AML_fromMOPCode; getKeyValue("web.customers.webewires.frommop.poli"))
								
								
							: ($status="Unused")
								
							: ($status="Activated")
								
							: ($status="PartPaid")  //we don't currently allow this
								
							: ($status="Future")  //we don't currently allow this
								
							Else 
								
						End case 
						
						//If ([WebEWires]status>=0) & ([WebEWires]status<=5)
						//[WebEWires]status:=$newStatus  //10  //pending review
						//End if 
						
						[WebEWires:149]paymentInfo:35.gateway:="polipaylink"  //make sure it is set
						
						SAVE RECORD:C53([WebEWires:149])
						
						If ($readOnlyStatus)
							UNLOAD RECORD:C212([WebEWires:149])
							READ ONLY:C145([WebEWires:149])
							LOAD RECORD:C52([WebEWires:149])
						End if 
						
					Else 
						$status:="UNKNOWN"  //poli failed to respons
					End if 
					
					
				Else 
					$status:="UNDEFINED"  //no polilnk
			End case 
			
		: ($gateway="polipayapi")
			Case of 
				: (OB Get type:C1230([WebEWires:149]paymentInfo:35; "url")=Is undefined:K8:13) & (OB Get type:C1230([WebEWires:149]paymentInfo:35; "poliLink")=Is undefined:K8:13)
					$status:="LINK Undefined"
					
				: ([WebEWires:149]paymentInfo:35.poliToken#"")  //token is there
					$return:=POLI_getForWebEwire([WebEWires:149]paymentInfo:35.poliToken)
					
					If ($return.success)
						UNLOAD RECORD:C212([WebEWires:149])
						LOAD RECORD:C52([WebEWires:149])
					Else 
						$status:="UNKNOWN"  //poli failed to respons
					End if 
					
				Else 
					$status:="UNDEFINED"  //no polilnk
			End case 
			
			If ($status="")
				$status:=String:C10([WebEWires:149]status:16)
			End if 
			
			
			
		: ($gateway="adyenlink")
			
		: ($gateway="square")
			Case of 
				: (OB Get type:C1230([WebEWires:149]paymentInfo:35; "url")=Is undefined:K8:13)
					$status:="LINK Undefined"
				: ([WebEWires:149]paymentInfo:35.url#"")  //
					
					$return:=SQ_getOrderDetails([WebEWires:149]paymentInfo:35.transactionRefNo)  //storing order id here
					
					If ($return.success)
						
						If ($return.payment_id=Null:C1517)
						Else 
							[WebEWires:149]paymentInfo:35.transactionId:=$return.payment_id
						End if 
						
						[WebEWires:149]paymentInfo:35.order:=$return.order
						SAVE RECORD:C53([WebEWires:149])
						
						If ($return.payment_id=Null:C1517)  //nothing to check yet
						Else 
							$return:=SQ_getPaymentDetails([WebEWires:149]paymentInfo:35.transactionId)
							
							If ($return.success)
								
								[WebEWires:149]paymentInfo:35.status:=$return.statusText
								[WebEWires:149]paymentInfo:35.payment:=$return.payment
								
								Case of 
									: ($return.statusText="COMPLETED")
										[WebEWires:149]status:16:=10
									: ($return.statusText="APPROVED")
										[WebEWires:149]status:16:=10
									: ($return.statusText="CANCELLED")
										[WebEWires:149]status:16:=-10
										[WebEWires:149]isCancelled:20:=True:C214
									: ($return.statusText="FAILED")
										[WebEWires:149]status:16:=-10  //cancelled due to bank specific failure
										[WebEWires:149]isCancelled:20:=True:C214
									: ($return.statusText="PENDING")
										
									: ($return.statusText="UNKNOWN")
										
									: ($return.statusText="NOT FOUND")
									Else 
										//TRACE
								End case 
								
								
								SAVE RECORD:C53([WebEWires:149])
								UNLOAD RECORD:C212([WebEWires:149])
								LOAD RECORD:C52([WebEWires:149])
							End if 
							
						End if 
						
						
					End if 
					
					$status:=[WebEWires:149]paymentInfo:35.status
					
					
					
				Else 
					$status:="UNDEFINED"  //no url
			End case 
			
			
		: ($gateway="paymark")
			
			Case of 
				: (OB Get type:C1230([WebEWires:149]paymentInfo:35; "url")=Is undefined:K8:13)
					$status:="LINK Undefined"
				: ([WebEWires:149]paymentInfo:35.url#"")  //configured for poliLink payment
					
					If (True:C214)
						$return:=PMARK_getForWebEwire([WebEWires:149]WebEwireID:1)
						
						If ($return.success)
							UNLOAD RECORD:C212([WebEWires:149])
							LOAD RECORD:C52([WebEWires:149])
						End if 
						
						$status:=[WebEWires:149]paymentInfo:35.status
						
						
					Else   // OLD METHOD
						$return:=PMARK_getTransaction([WebEWires:149]paymentInfo:35.transactionId)
						
						If ($return.success)
							$status:=$return.status
							
							$readOnlyStatus:=Read only state:C362([WebEWires:149])
							READ WRITE:C146([WebEWires:149])
							Repeat 
								LOAD RECORD:C52([WebEWires:149])
							Until (Not:C34(Locked:C147([WebEWires:149])))
							
							OBJ_newPaymentInfo(->[WebEWires:149]paymentInfo:35)
							[WebEWires:149]paymentInfo:35.status:=$status
							[WebEWires:149]paymentInfo:35.confirmationId:=$return.response.receiptNumber
							[WebEWires:149]paymentInfo:35.transactionDateTime:=$return.response.transactionDate
							
							ARRAY TEXT:C222($atProperties; 0)
							OB GET PROPERTY NAMES:C1232($return.response; $atProperties)
							For ($i; 1; Size of array:C274($atProperties))
								OB SET:C1220([WebEWires:149]paymentInfo:35.paymentData; $atProperties{$i}; $return.response[$atProperties{$i}])
							End for 
							
							If ([WebEWires:149]status:16<10) & ([WebEWires:149]status:16>=0)
								[WebEWires:149]status:16:=10
							End if 
							
							[WebEWires:149]AML_Info:9[AML_fromMOPCode]:=getKeyValue("web.customers.webewires.frommop.paymark")
							
							Case of 
								: ([WebEWires:149]paymentInfo:35.status="SUCCESSFUL")
									[WebEWires:149]status:16:=10
								: ([WebEWires:149]paymentInfo:35.status="CANCELLED")
									[WebEWires:149]status:16:=-10
									[WebEWires:149]isCancelled:20:=True:C214
								: ([WebEWires:149]paymentInfo:35.status="FAILED")
									[WebEWires:149]status:16:=-10  //cancelled due to bank specific failure
									[WebEWires:149]isCancelled:20:=True:C214
								: ([WebEWires:149]paymentInfo:35.status="DECLINED")
									[WebEWires:149]status:16:=-20  //denied
									[WebEWires:149]isCancelled:20:=True:C214
								: ([WebEWires:149]paymentInfo:35.status="BLOCKED")
									[WebEWires:149]status:16:=-20  //denied
									[WebEWires:149]isCancelled:20:=True:C214
								: ([WebEWires:149]paymentInfo:35.status="INPROGRESS")
									[WebEWires:149]status:16:=0
								: ([WebEWires:149]paymentInfo:35.status="UNKNOWN")
									[WebEWires:149]status:16:=0
								Else 
									//TRACE
									[WebEWires:149]status:16:=0
							End case 
							
							
							SAVE RECORD:C53([WebEWires:149])
							
							If ($readOnlyStatus)
								UNLOAD RECORD:C212([WebEWires:149])
								READ ONLY:C145([WebEWires:149])
								LOAD RECORD:C52([WebEWires:149])
							End if 
							
						Else 
							$status:="UNKNOWN"  //poli failed to respons
						End if 
					End if 
					
				Else 
					$status:="UNDEFINED"  //no polilnk
			End case 
			
			If ($status="")
				$status:=String:C10([WebEWires:149]status:16)
			End if 
			
		: ($gateway="")
			$status:="NO PAYMENT GATEWAY"
		Else   //no gateway configured
			$status:="Not Configured: "+$gateway
	End case 
	
Else 
	$status:="UNDEFINED"  //no gateway/payment info at all
End if 

$0:=$status