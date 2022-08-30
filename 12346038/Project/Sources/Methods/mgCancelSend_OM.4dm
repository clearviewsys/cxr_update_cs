//%attributes = {}
// object method for MoneyGram Cancel Send button

C_OBJECT:C1216($status)
C_TEXT:C284($currOnErr)

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		OBJECT SET VISIBLE:C603(*; "b_cancelSend@"; False:C215)
		OBJECT SET ENABLED:C1123(*; "b_cancelSend@"; False:C215)
		
		$currOnErr:=Method called on error:C704
		ON ERR CALL:C155("onErrCallIgnore")
		
		If ([WebEWires:149]paymentInfo:35.result.transactionType="Send")
			If ([WebEWires:149]paymentInfo:35.invoiceID="")
				If (mgGetDateFromProfixDateTime([WebEWires:149]paymentInfo:35.result.transactionDateTime)=Current date:C33)
					If (Not:C34([WebEWires:149]isCancelled:20))
						OBJECT SET VISIBLE:C603(*; "b_cancelSend@"; True:C214)
						OBJECT SET ENABLED:C1123(*; "b_cancelSend@"; True:C214)
					End if 
				End if 
			End if 
		End if 
		
		ON ERR CALL:C155($currOnErr)
		
		
	: (Form event code:C388=On Clicked:K2:4)
		
		If ([WebEWires:149]paymentInfo:35.result.transactionType="Send")
			
			If (mgGetDateFromProfixDateTime([WebEWires:149]paymentInfo:35.result.transactionDateTime)=Current date:C33)
				
				If (Not:C34([WebEWires:149]isCancelled:20))
					
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
							
							OBJECT SET VISIBLE:C603(*; "b_cancelSend"; False:C215)
							OBJECT SET ENABLED:C1123(*; "b_cancelSend"; False:C215)
							
							myAlert("MoneyGram Send Transaction "+[WebEWires:149]paymentInfo:35.result.referenceNumber+" cancelled!")
							
						Else 
							
							myAlert("Error occured. "+mgGetSOAPErrorDetails($status.mgerrormsg))
							
						End if 
					End if 
					
				End if 
				
			End if 
			
			
		End if 
		
		
End case 
