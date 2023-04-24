//%attributes = {}
// object method for MoneyGram Cancel Send button

C_OBJECT:C1216($status)
C_TEXT:C284($currOnErr; $msg; $reason)
C_BOOLEAN:C305($okToCancel; $connectedToInvoice; $success)

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		
		If (webEwiresIsMoneyGram([WebEWires:149]WebEwireID:1))
			
			OBJECT SET ENABLED:C1123(*; "b_cancelSend@"; False:C215)
			
			$currOnErr:=Method called on error:C704
			ON ERR CALL:C155("onErrCallIgnore")
			
			If ([WebEWires:149]paymentInfo:35.result.transactionType="Send")
				// removed check for existance of Invoice in order to allow cancellation of staged transactions
				// If ([WebEWires]paymentInfo.invoiceID="")
				
				If (Not:C34([WebEWires:149]isCancelled:20))
					
					Case of 
						: ([WebEWires:149]paymentInfo:35.origin="profix@")  // added per Surinder
							OBJECT SET VISIBLE:C603(*; "b_cancelSend@"; True:C214)
							OBJECT SET ENABLED:C1123(*; "b_cancelSend@"; True:C214)
							
						: (mgIsWithinLast24hours([WebEWires:149]paymentInfo:35.result.transactionDateTime))
							OBJECT SET VISIBLE:C603(*; "b_cancelSend@"; True:C214)
							OBJECT SET ENABLED:C1123(*; "b_cancelSend@"; True:C214)
							
					End case 
					
				End if 
				// End if 
				
			End if 
		End if 
		
		ON ERR CALL:C155($currOnErr)
		
		
		
	: (Form event code:C388=On Clicked:K2:4)
		
		$okToCancel:=True:C214
		$connectedToInvoice:=False:C215
		
		If ([WebEWires:149]paymentInfo:35.result.transactionType="Send")
			
			If (mgIsWithinLast24hours([WebEWires:149]paymentInfo:35.result.transactionDateTime)) | ([WebEWires:149]paymentInfo:35.origin="profix@")
				
				If (Not:C34([WebEWires:149]isCancelled:20))
					
					If ([WebEWires:149]paymentInfo:35.invoiceID#Null:C1517)
						If ([WebEWires:149]paymentInfo:35.invoiceID#"")
							READ ONLY:C145([Invoices:5])
							QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=[WebEWires:149]paymentInfo:35.invoiceID)
							If (Records in selection:C76([Invoices:5])=1)
								$connectedToInvoice:=True:C214
								myConfirm("This MoneyGram transaction is already invoiced. If canceling is successful, Invoice will be voided also. Should we proceed with cancellation?"\
									; "Yes, cancel transaction"; "Don't cancel transaction")
								If (OK=1)
									$reason:=myRequest("Enter the reason for cancelling this transaction.")
								Else 
									$okToCancel:=False:C215
								End if 
							End if 
						End if 
					End if 
					
					If ($okToCancel)
						
						$status:=mgCancelSendTransaction("INCORRECT_AMT"; [WebEWires:149]paymentInfo:35.result.referenceNumber)
						
						If ($status.sendCancel#Null:C1517)
							If ($status.sendCancel.TransferState="70")
								
								READ WRITE:C146([WebEWires:149])
								LOAD RECORD:C52([WebEWires:149])
								[WebEWires:149]isCancelled:20:=True:C214
								[WebEWires:149]paymentInfo:35.result.isCancelled:=True:C214
								[WebEWires:149]paymentInfo:35.sendCancel:=$status.sendCancel
								[WebEWires:149]paymentInfo:35.sendCancel.cancelDate:=Current date:C33
								[WebEWires:149]paymentInfo:35.sendCancel.cancelTime:=Current time:C178
								SAVE RECORD:C53([WebEWires:149])
								UNLOAD RECORD:C212([WebEWires:149])
								READ ONLY:C145([WebEWires:149])
								LOAD RECORD:C52([WebEWires:149])
								
								tPaymentInfo:=JSON Stringify:C1217([WebEWires:149]paymentInfo:35; *)
								
								OBJECT SET VISIBLE:C603(*; "b_cancelSend@"; False:C215)
								OBJECT SET ENABLED:C1123(*; "b_cancelSend@"; False:C215)
								
								$msg:="MoneyGram Send Transaction "+[WebEWires:149]paymentInfo:35.result.referenceNumber+" cancelled! "
								
								If ($connectedToInvoice)
									$msg:=$msg+"\nInvoice "+[WebEWires:149]paymentInfo:35.invoiceID+" will be cancelled now."
									$success:=handleCancelInvoiceButton(True:C214; $reason)
									If (Not:C34($success))
										myAlert("Invoice cancellation failed, you should do it manually, MoneyGram transaction is cancelled.")
									End if 
								Else 
									myAlert($msg)
								End if 
								
							Else 
								myAlert("Error occured. "+mgGetSOAPErrorDetails($status.mgerrormsg))
							End if 
						Else 
							myAlert("Error occured. "+mgGetSOAPErrorDetails($status.mgerrormsg))
						End if 
						
					End if 
					
				Else 
					
					myAlert("MoneyGram transaction is already cancelled!")
					
				End if 
				
			Else 
				
				myAlert("MoneyGram transaction is older than 24 hours!")
				
			End if 
			
		Else 
			myAlert("This can not be cancelled because it is of type: "+[WebEWires:149]paymentInfo:35.result.transactionType)
		End if 
		
		
End case 
