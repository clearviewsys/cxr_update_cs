
C_OBJECT:C1216($return; $response)
C_BOOLEAN:C305($readOnlyStatus)
C_LONGINT:C283($i)
C_TEXT:C284($status)


Case of 
	: (Form event code:C388=On Load:K2:1)
		
		//If (Current user="designer")
		//OBJECT SET VISIBLE(Self->;True)
		//Else 
		//OBJECT SET VISIBLE(Self->;False)
		//End if 
		
	Else 
		//If (Current user="designer")
		Case of 
			: ([WebEWires:149]paymentInfo:35.gateway="paymark")
				If ([WebEWires:149]paymentInfo:35.url#"")
					
					$response:=New object:C1471
					$return:=New object:C1471
					
					$return.success:=False:C215
					
					Case of 
						: ([WebEWires:149]paymentInfo:35.transactionId=Null:C1517)
							$return:=PMARK_searchTransaction(New object:C1471("reference"; [WebEWires:149]WebEwireID:1; "startDate"; [WebEWires:149]creationDate:15; "endDate"; [WebEWires:149]creationDate:15+1))
							If ($return.response.length>0)
								$response:=$return.response[0]
							End if 
							
						: (OB Get:C1224([WebEWires:149]paymentInfo:35; "transactionId"; Is text:K8:3)="")  //([WebEWires]paymentInfo.transactionId="")
							$return:=PMARK_searchTransaction(New object:C1471("reference"; [WebEWires:149]WebEwireID:1; "startDate"; [WebEWires:149]creationDate:15; "endDate"; [WebEWires:149]creationDate:15+1))
							If ($return.response.length>0)
								$response:=$return.response[0]
							End if 
							
						Else 
							$return:=PMARK_getTransaction(OB Get:C1224([WebEWires:149]paymentInfo:35; "transactionId"; Is text:K8:3))  // ([WebEWires]paymentInfo.transactionId)
							$response:=$return.response
					End case 
					
					If ($return.success)
						$status:=$return.status
						myAlert($status)
						myConfirm("Shall I update this record?")
						
						If (OK=1)
							$readOnlyStatus:=Read only state:C362([WebEWires:149])
							READ WRITE:C146([WebEWires:149])
							Repeat 
								LOAD RECORD:C52([WebEWires:149])
							Until (Not:C34(Locked:C147([WebEWires:149])))
							
							$status:=$return.status
							[WebEWires:149]paymentInfo:35.status:=$status
							[WebEWires:149]paymentInfo:35.status:=$response.status  //same as above
							
							If ([WebEWires:149]paymentInfo:35.transactionId="")  //don't change
								[WebEWires:149]paymentInfo:35.transactionId:=$response.transactionId
							End if 
							
							[WebEWires:149]paymentInfo:35.transactionDateTime:=$response.transactionDate
							[WebEWires:149]paymentInfo:35.paymentMethod:="eft"
							
							ARRAY TEXT:C222($atProperties; 0)
							OB GET PROPERTY NAMES:C1232($response; $atProperties)
							For ($i; 1; Size of array:C274($atProperties))
								OB SET:C1220([WebEWires:149]paymentInfo:35.paymentData; $atProperties{$i}; $response[$atProperties{$i}])
							End for 
							
							Case of 
								: ($status="@SUCCESSFUL@")
									If ([WebEWires:149]status:16<10) & ([WebEWires:149]status:16>=0)
										[WebEWires:149]status:16:=10
									End if 
									OB SET:C1220([WebEWires:149]AML_Info:9; AML_fromMOPCode; getKeyValue("web.customers.webewires.frommop.paymark"))
									
								: ($status="Cancelled")
									[WebEWires:149]status:16:=-10
									[WebEWires:149]isCancelled:20:=True:C214
									
								: ($status="Failed")
									[WebEWires:149]status:16:=-20
									[WebEWires:149]isCancelled:20:=True:C214
									
								: ($status="ReceiptUnverified")
									[WebEWires:149]status:16:=-10
									[WebEWires:149]isCancelled:20:=True:C214
									
								: ($status="TimeOut@") | ($status="TimedOut@")
									[WebEWires:149]status:16:=-10
									[WebEWires:149]isCancelled:20:=True:C214
									
								Else   //other error code
									[WebEWires:149]status:16:=5  //leave as pending for now
							End case 
							
							[WebEWires:149]paymentInfo:35.gateway:="paymark"  //make sure it is set
							
							SAVE RECORD:C53([WebEWires:149])
							
							If ($readOnlyStatus)
								UNLOAD RECORD:C212([WebEWires:149])
								READ ONLY:C145([WebEWires:149])
								LOAD RECORD:C52([WebEWires:149])
							End if 
							
						End if 
						
					Else 
						myAlert("ERROR: Transaction not found.")
					End if 
				Else 
					myAlert("Paymark payment URL is undefined.")
				End if 
				
			: ([WebEWires:149]paymentInfo:35.gateway="poli@")
				If ([WebEWires:149]paymentInfo:35.url#"")  //configured for poliLink payment
					$return:=POLI_getTransaction([WebEWires:149]paymentInfo:35.poliToken)
					
					If ($return.success)
						$status:=$return.status
						myAlert($status)
						myConfirm("Shall I update this record?")
						
						If (OK=1)
							$readOnlyStatus:=Read only state:C362([WebEWires:149])
							READ WRITE:C146([WebEWires:149])
							Repeat 
								LOAD RECORD:C52([WebEWires:149])
							Until (Not:C34(Locked:C147([WebEWires:149])))
							
							[WebEWires:149]paymentInfo:35.status:=$status
							[WebEWires:149]paymentInfo:35.status:=$return.response.TransactionStatusCode  //same as above
							[WebEWires:149]paymentInfo:35.transactionId:=$return.response.TransactionID
							[WebEWires:149]paymentInfo:35.transactionDateTime:=$return.response.EstablishedDateTime
							
							If ($return.response.BankReceipt="")
								[WebEWires:149]paymentInfo:35.confirmationID:=$return.response.TransactionRefNo
							Else 
								[WebEWires:149]paymentInfo:35.confirmationID:=$return.response.BankReceipt
							End if 
							[WebEWires:149]paymentInfo:35.paymentMethod:="POLI"
							
							ARRAY TEXT:C222($atProperties; 0)
							OB GET PROPERTY NAMES:C1232($return.response; $atProperties)
							
							If (Size of array:C274($atProperties)>0)
								If ([WebEWires:149]paymentInfo:35.paymentData=Null:C1517)
									[WebEWires:149]paymentInfo:35.paymentData:=New object:C1471
								End if 
								
								For ($i; 1; Size of array:C274($atProperties))
									OB SET:C1220([WebEWires:149]paymentInfo:35.paymentData; $atProperties{$i}; $return.response[$atProperties{$i}])
								End for 
								
							End if 
							
							Case of 
								: ($status="Completed")
									If ([WebEWires:149]status:16<10) & ([WebEWires:149]status:16>=0)
										[WebEWires:149]status:16:=10
									End if 
									OB SET:C1220([WebEWires:149]AML_Info:9; AML_fromMOPCode; getKeyValue("web.customers.webewires.frommop.poli"))
									
								: ($status="Cancelled")
									[WebEWires:149]status:16:=-10
									[WebEWires:149]isCancelled:20:=True:C214
									
								: ($status="Failed")
									[WebEWires:149]status:16:=-20
									[WebEWires:149]isCancelled:20:=True:C214
									
								: ($status="ReceiptUnverified")
									[WebEWires:149]status:16:=-10
									[WebEWires:149]isCancelled:20:=True:C214
									
								: ($status="TimeOut@") | ($status="TimedOut@")
									[WebEWires:149]status:16:=-10
									[WebEWires:149]isCancelled:20:=True:C214
									
								Else   //other error code
									[WebEWires:149]status:16:=5  //leave as pending for now
							End case 
							
							[WebEWires:149]paymentInfo:35.gateway:="polipayapi"  //make sure it is set
							
							SAVE RECORD:C53([WebEWires:149])
							
							If ($readOnlyStatus)
								UNLOAD RECORD:C212([WebEWires:149])
								READ ONLY:C145([WebEWires:149])
								LOAD RECORD:C52([WebEWires:149])
							End if 
							
							
						End if 
						
					End if 
					
				End if 
				
		End case 
		
		//End if 
End case 