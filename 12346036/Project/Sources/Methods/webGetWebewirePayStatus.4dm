//%attributes = {"shared":true,"publishedWeb":true}
C_OBJECT:C1216($1; $we)

C_TEXT:C284($0; $statusText)

C_TEXT:C284($gateway)
C_OBJECT:C1216($status; $entity)
C_BOOLEAN:C305($readonly)

$statusText:="UNKNOWN"

C_OBJECT:C1216($payment)


If (Count parameters:C259>=1)
	$we:=$1
Else 
	$we:=New object:C1471
	$we:=Create entity selection:C1512([WebEWires:149])  //assume we have the record
End if 


Case of 
		//what if $we is emmpty
	: ($we.length=0)  //new record
		$statusText:="NEW"
		
	: (OB Get type:C1230($we.first(); "paymentInfo")=Is null:K8:31)
		$statusText:=getWebEWireStatusText
		
	: ($we.first().status>=30)  //invoiced and sent so assume payment completed
		$statusText:="completed"
		
	Else 
		If (OB Is defined:C1231($we.first().paymentInfo))
			$payment:=$we.first().paymentInfo
			$statusText:=$we.first().paymentInfo.status
			$gateway:=$we.first().paymentInfo.gateway
			
			If ($statusText="") | ($statusText="2") | ($statusText="NEW")
				Case of 
					: ($gateway="polipaylink")
						// status options: completed, unused, activated, partpaid, future
						
					: ($gateway="polipayapi")
						//final status options = completed, cancelled, failed, receiptUnverified, timedOut
						//in process options = initiated, financialInstitution selected eulaAccepted, inProcess, Unknown
						
						If ($payment.poliLink#Null:C1517)
							//should recheck status right now
							$statusText:="NEW"  //give user option to pay now
						Else   //errro getting a poliLink
							// retry to get a link
							$readonly:=Read only state:C362([WebEWires:149])
							If ($readonly)
								UNLOAD RECORD:C212([WebEWires:149])
								READ WRITE:C146([WebEWires:149])
								LOAD RECORD:C52([WebEWires:149])
							End if 
							
							$status:=POLI_InitiateForWebEwire
							If ($status.success)
								SAVE RECORD:C53([WebEWires:149])
								$statusText:="NEW"
							Else 
								$statusText:="ERROR"
							End if 
							
							If ($readonly)
								UNLOAD RECORD:C212([WebEWires:149])
								READ ONLY:C145([WebEWires:149])
								LOAD RECORD:C52([WebEWires:149])
							End if 
							
						End if 
						
						
					: ($gateway="paymark")
						//0=UNKNOWN, 1=SUCCESSFUL, 2=DECLINED, 3=BLOCKED, 4=FAILED, 5=INPROGRESS, 6=CANCELLED.
						
						Case of 
							: ($payment.url=Null:C1517)  // retry to get a link
								$readonly:=Read only state:C362([WebEWires:149])
								If ($readonly)
									UNLOAD RECORD:C212([WebEWires:149])
									READ WRITE:C146([WebEWires:149])
									LOAD RECORD:C52([WebEWires:149])
								End if 
								
								$status:=PMARK_initiateForWebEwire
								
								If ($status.success)
									$statusText:="NEW"
								Else 
									$statusText:="ERROR"
								End if 
								
								If ($readonly)
									UNLOAD RECORD:C212([WebEWires:149])
									READ ONLY:C145([WebEWires:149])
									LOAD RECORD:C52([WebEWires:149])
								End if 
								
								
							: ($payment.url="")
								$readonly:=Read only state:C362([WebEWires:149])
								If ($readonly)
									UNLOAD RECORD:C212([WebEWires:149])
									READ WRITE:C146([WebEWires:149])
									LOAD RECORD:C52([WebEWires:149])
								End if 
								
								$status:=PMARK_initiateForWebEwire
								
								If ($status.success)
									$statusText:="NEW"
								Else 
									$statusText:="ERROR"
								End if 
								
								If ($readonly)
									UNLOAD RECORD:C212([WebEWires:149])
									READ ONLY:C145([WebEWires:149])
									LOAD RECORD:C52([WebEWires:149])
								End if 
								
								
							Else   //should recheck status right now
								
								$status:=PMARK_getForWebEwire($we.first().WebEwireID)
								If ($status.success)
									$statusText:=$status.statusText
								Else 
									$statusText:="NEW"  //give user option to pay now
								End if 
						End case 
						
						
					: ($gateway="square")
						// STATUS: APPROVED, PENDING, COMPLETED, CANCELED, or FAILED
						$entity:=$we.first()
						
						Case of 
							: (False:C215)  // testing
								$statusText:=$entity.paymentInfo.status
							: ($payment.url=Null:C1517)  // no URL so error
								$statusText:="UNKNOWN"
							: ($payment.url="")  // no URL so error
								$statusText:="UNKNOWN"
							Else   //should recheck status right now
								
								If (False:C215)
									$statusText:=$entity.paymentInfo.status
								Else 
									
									Case of 
										: ($entity.paymentInfo.payment_link=Null:C1517)
											$statusText:="NEW"
										: ($entity.paymentInfo.payment_link.order_id=Null:C1517)
											$statusText:="NEW"
										: ($entity.paymentInfo.payment_link.order_id="")
											$statusText:="NEW"
										Else 
											$status:=SQ_getOrderDetails($entity.paymentInfo.payment_link.order_id)
											
											If ($status.success)  // now we can check for payment details
												$entity.paymentInfo.transactionId:=$status.payment_id
												$entity.paymentInfo.status:=$status.statusText
												$entity.paymentInfo.order:=$status.order
												
												If ($entity.paymentInfo.transactionId="")
													$statusText:="NEW"
												Else 
													$status:=SQ_getPaymentDetails($entity.paymentInfo.transactionId)
													
													If ($status.success)
														$entity.paymentInfo.status:=$status.statusText
														$entity.paymentInfo.payment:=$status.payment
														
														Case of 
															: ($status.statusText="COMPLETED")
																$entity.status:=10
															: ($status.statusText="APPROVED")
																$entity.status:=10
															: ($status.statusText="CANCELLED")
																$entity.status:=-10
																$entity.isCancelled:=True:C214
															: ($status.statusText="FAILED")
																$entity.status:=-10  //cancelled due to bank specific failure
																$entity.isCancelled:=True:C214
															: ($status.statusText="PENDING")
																
															: ($status.statusText="UNKNOWN")
																
															: ($status.statusText="NOT FOUND")
															Else 
																//TRACE
														End case 
														
														$statusText:=$status.statusText
														
														$status:=$entity.save()
														If ($status.success)
														Else 
															ALERT:C41("save failed")
														End if 
														
													End if 
												End if 
												
											Else 
												$statusText:="NEW"  //give user option to pay now
											End if 
											
									End case 
									
								End if 
								
						End case 
						
						
						
					Else 
						$statusText:="UNDEFINED-Gateway Unknown"
				End case 
				
			End if 
		End if 
End case 


$0:=$statusText