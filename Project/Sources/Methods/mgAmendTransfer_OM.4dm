//%attributes = {}
C_OBJECT:C1216($status; $formObj; $result; $oldReceiver)
C_TEXT:C284($currOnErr)
C_LONGINT:C283($winref)

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		//OBJECT SET VISIBLE(*;"b_amendTransfer@";False)
		OBJECT SET ENABLED:C1123(*; "b_amendTransfer@"; False:C215)
		
		$currOnErr:=Method called on error:C704
		ON ERR CALL:C155("onErrCallIgnore")
		
		If ([WebEWires:149]paymentInfo:35.result.transactionType="Send")
			//If ([WebEWires]paymentInfo.invoiceID="")
			If (Not:C34([WebEWires:149]isCancelled:20))
				If ([WebEWires:149]paymentInfo:35.result.referenceNumber#Null:C1517)
					OBJECT SET VISIBLE:C603(*; "b_amendTransfer@"; True:C214)
					OBJECT SET ENABLED:C1123(*; "b_amendTransfer@"; True:C214)
				End if 
			End if 
			//End if 
		End if 
		
		ON ERR CALL:C155($currOnErr)
		
		
	: (Form event code:C388=On Clicked:K2:4)
		
		If ([WebEWires:149]paymentInfo:35.result.transactionType="Send")
			
			If (Not:C34([WebEWires:149]isCancelled:20))
				
				$formObj:=New object:C1471
				$formObj.ReceiverLastName:=[WebEWires:149]paymentInfo:35.passedToMoneyGram.receiverLastName
				$formObj.ReceiverName:=[WebEWires:149]paymentInfo:35.passedToMoneyGram.receiverFirstName
				$formObj.ReceiverLastName2:=[WebEWires:149]paymentInfo:35.passedToMoneyGram.receiverLastName2
				$formObj.ReceiverSurName:=[WebEWires:149]paymentInfo:35.passedToMoneyGram.receiverMiddleName
				
				$oldReceiver:=OB Copy:C1225($formObj)
				
				$winref:=Open form window:C675("mgSendEdit")
				DIALOG:C40("mgSendEdit"; $formObj)
				CLOSE WINDOW:C154
				
				If (OK=1)
					
					$result:=mgSendEdit([WebEWires:149]paymentInfo:35.result.referenceNumber; $formObj)
					
					If ($result.success)
						
						READ WRITE:C146([WebEWires:149])
						LOAD RECORD:C52([WebEWires:149])
						
						// $isLocked:=Locked([WebEWires])
						
						[WebEWires:149]paymentInfo:35.passedToMoneyGram.receiverLastName:=$formObj.ReceiverLastName
						[WebEWires:149]paymentInfo:35.passedToMoneyGram.receiverFirstName:=$formObj.ReceiverName
						[WebEWires:149]paymentInfo:35.passedToMoneyGram.receiverLastName2:=$formObj.ReceiverLastName2
						[WebEWires:149]paymentInfo:35.passedToMoneyGram.receiverMiddleName:=$formObj.ReceiverSurName
						
						// ibb added
						If ([WebEWires:149]toParty:8=Null:C1517)
							[WebEWires:149]toParty:8:=New object:C1471
						End if 
						[WebEWires:149]toParty:8[Info_FirstName]:=$formObj.ReceiverName
						[WebEWires:149]toParty:8[Info_LastName]:=$formObj.ReceiverLastName+" "+$formObj.ReceiverLastName2
						[WebEWires:149]toParty:8[Info_FullName]:=[WebEWires:149]toParty:8[Info_FirstName]+" "+[WebEWires:149]toParty:8[Info_LastName]
						
						
						If ([WebEWires:149]paymentInfo:35.amends=Null:C1517)
							[WebEWires:149]paymentInfo:35.amends:=New collection:C1472
						End if 
						
						$oldReceiver.whenDate:=Current date:C33
						$oldReceiver.whenTime:=String:C10(Current time:C178; HH MM SS:K7:1)
						[WebEWires:149]paymentInfo:35.amends.push($oldReceiver)
						
						SAVE RECORD:C53([WebEWires:149])
						UNLOAD RECORD:C212([WebEWires:149])
						READ ONLY:C145([WebEWires:149])
						LOAD RECORD:C52([WebEWires:149])
						
						Form:C1466.paymentInfo:=[WebEWires:149]paymentInfo:35
						tPaymentInfo:=JSON Stringify:C1217([WebEWires:149]paymentInfo:35; *)
						
						myAlert("Amend done")
						
					Else 
						
						If ($result.mgerrormsg#Null:C1517)
							myAlert("Error amending, MoneyGram SOAP API returned: "+mgGetSOAPErrorDetails($result.mgerrormsg))
						Else 
							myAlert("Error amending: ")
						End if 
						
					End if 
					
				End if 
				
				
			End if 
			
		End if 
		
		
End case 
