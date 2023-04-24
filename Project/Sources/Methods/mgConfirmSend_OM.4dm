//%attributes = {}
// confirm staged send transaction

C_OBJECT:C1216($result; $transfer; $stagingCredentials)
C_COLLECTION:C1488($statuses)
C_TEXT:C284($confirmationNumber; $sendAmount; $currOnErr)

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		OBJECT SET ENABLED:C1123(*; "b_confirmStagedSend"; False:C215)
		
		$currOnErr:=Method called on error:C704
		ON ERR CALL:C155("onErrCallIgnore")
		
		If (webEwiresIsMoneyGram([WebEWires:149]WebEwireID:1))
			
			If ([WebEWires:149]paymentInfo:35.passedToMoneyGram.transactionType="Send")
				
				If (mgIsWithinLast24hours([WebEWires:149]paymentInfo:35.result.transactionDateTime))
					
					If ([WebEWires:149]status:16#20)
						
						If (Not:C34([WebEWires:149]isCancelled:20))
							
							Case of 
								: ([WebEWires:149]paymentInfo:35.origin=Null:C1517)
								: ([WebEWires:149]paymentInfo:35.origin="SOAP")
									
									If ([WebEWires:149]status:16>=20)  // our internal status, not MoneyGram status
										
										If ([WebEWires:149]paymentInfo:35.result.referenceNumber=Null:C1517)
											OBJECT SET VISIBLE:C603(*; "b_confirmStagedSend"; True:C214)
											OBJECT SET ENABLED:C1123(*; "b_confirmStagedSend"; True:C214)
										End if 
										
									End if 
									
							End case 
							
						End if 
						
					End if 
					
				End if 
				
			End if 
			
		End if 
		
		ON ERR CALL:C155($currOnErr)
		
		
	: (Form event code:C388=On Clicked:K2:4)
		
		If (Form:C1466.paymentInfo.soap.result.result.TransferSysId#Null:C1517)
			
			$confirmationNumber:=[WebEWires:149]paymentInfo:35.soap.result.result.ConfirmationNumber
			$sendAmount:=String:C10([WebEWires:149]paymentInfo:35.soap.passed.TransferSendAmount)
			
			$stagingCredentials:=mgGetCredentialsForStaged
			
			If ($stagingCredentials=Null:C1517)
				myConfirm("Couldn't get credentials for confirming staged transactions. Use your credentials?"; "Use"; "Cancel confirmation")
				If (OK=1)
					$stagingCredentials:=mgGetCredentials
				End if 
			End if 
			
			If ($stagingCredentials#Null:C1517)
				
				$transfer:=mgGetTransferByFormFreeStageNum($confirmationNumber; $sendAmount; $stagingCredentials)
				
				If ($transfer.success)
					
					If ($transfer.result#Null:C1517)
						
						If ($transfer.result.length>0)
							
							$result:=mgSendConfirm($transfer.result[0].TransferSysId; $stagingCredentials)
							
							If ($result.success)
								
								READ WRITE:C146([WebEWires:149])
								LOAD RECORD:C52([WebEWires:149])
								[WebEWires:149]paymentInfo:35.soap.sendConfirm:=$result.sendConfirm
								[WebEWires:149]paymentInfo:35.soap.getTransfer:=$transfer
								
								// create result property in Webewire
								If ([WebEWires:149]paymentInfo:35.result=Null:C1517)
									[WebEWires:149]paymentInfo:35.result:=New object:C1471
								End if 
								[WebEWires:149]paymentInfo:35.result.transactionType:="Send"
								[WebEWires:149]paymentInfo:35.result.destinationCountry:=[WebEWires:149]toCountryCode:12
								If ([WebEWires:149]paymentInfo:35.soap.sendConfirm#Null:C1517)
									[WebEWires:149]paymentInfo:35.result.referenceNumber:=[WebEWires:149]paymentInfo:35.soap.sendConfirm.TransferNumber
									$statuses:=mgGetStatuses
									$statuses:=$statuses.query("statusCode = :1"; Num:C11([WebEWires:149]paymentInfo:35.soap.sendConfirm.TransferState))
									If ($statuses.length>0)
										[WebEWires:149]paymentInfo:35.result.transactionStatus:=$statuses[0].status
									End if 
								End if 
								[WebEWires:149]paymentInfo:35.result.sendAmount:=[WebEWires:149]paymentInfo:35.passedToMoneyGram.sendAmount
								[WebEWires:149]paymentInfo:35.result.sendCurrency:=[WebEWires:149]paymentInfo:35.passedToMoneyGram.sendCurrency
								If ([WebEWires:149]paymentInfo:35.soap.getTransfer.result#Null:C1517)
									If ([WebEWires:149]paymentInfo:35.soap.getTransfer.result.length>0)
										[WebEWires:149]paymentInfo:35.result.receiveAmount:=[WebEWires:149]paymentInfo:35.soap.getTransfer.result[0].TransferAmount
										[WebEWires:149]paymentInfo:35.result.receiveCurrency:=\
											mgCurrencyID2CurrencyCode(Num:C11([WebEWires:149]paymentInfo:35.soap.getTransfer.result[0].TransferCurrency))
									End if 
								End if 
								[WebEWires:149]paymentInfo:35.result.rate:=[WebEWires:149]paymentInfo:35.soap.result.result.TransferExchangeRate
								[WebEWires:149]paymentInfo:35.result.sendFee:=[WebEWires:149]paymentInfo:35.soap.result.result.TransferTotalFeeAmount
								[WebEWires:149]paymentInfo:35.result.senderEmailAddress:=[WebEWires:149]paymentInfo:35.passedToMoneyGram.senderEmailAddress
								[WebEWires:149]paymentInfo:35.result.transactionDateTime:=\
									Replace string:C233([WebEWires:149]paymentInfo:35.soap.result.result.TransferSystemTransactionDate; " "; "+")
								//================
								
								[WebEWires:149]status:16:=20  // approved
								SAVE RECORD:C53([WebEWires:149])
								UNLOAD RECORD:C212([WebEWires:149])
								READ ONLY:C145([WebEWires:149])
								LOAD RECORD:C52([WebEWires:149])
								
								Form:C1466.paymentInfo:=[WebEWires:149]paymentInfo:35
								tPaymentInfo:=JSON Stringify:C1217([WebEWires:149]paymentInfo:35; *)
								
								myAlert("Transfer confirmed")
								
								OBJECT SET VISIBLE:C603(*; "b_confirmStagedSend"; False:C215)
								
							Else 
								
								myAlert("Error occured. "+mgGetSOAPErrorDetails($result.mgerrormsg))
								
							End if 
							
						End if 
					End if   // $transfer.result#Null
					
				Else 
					
					myAlert("Couldn't get transfer information from MoneyGram: "+mgGetSOAPErrorDetails($transfer.mgerrormsg))
					
				End if   // $transfer.success
				
			End if 
			
		Else 
			
			myAlert("Transfer ID not present.")
			
		End if 
		
End case 
