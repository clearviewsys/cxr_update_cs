//%attributes = {}
// handleSaveWireButton 
// this method is called from the save button for PAY/RECEIVE forms in [WireS]

C_BOOLEAN:C305($isOffline; $1)


C_TEXT:C284(vAML_POT; vAML_SOF)
//C_BOOLEAN(isEwirePrinted)
C_TEXT:C284($currErr)


vAML_POT:=""
vAML_SOF:=""
//isEwirePrinted:=False


If (Count parameters:C259=1)
	$isOffline:=$1
Else 
	$isOffline:=False:C215
End if 

//checkInit 

//If (isDuringInvoice )
//validateAccountPickedInInvoice 
//End if 

//validateeWires 

If (validateTable(->[eWires:13]))
	If (isDuringInvoice)
		
		setTableBranchDateTimeEtc(->[eWires:13]; ->[eWires:13]BranchID:50; ->[eWires:13]creationDate:53; ->[eWires:13]creationTime:54; ->[eWires:13]createdByUser:51; ->[eWires:13]modificationDate:55; ->[eWires:13]modificationTime:56; ->[eWires:13]modifiedByUser:52; ->[eWires:13]modBranchID:106)
		
		If ([eWires:13]securityChallengeCode:75="")
			[eWires:13]securityChallengeCode:75:=makeSecurityChallengeCode
		End if 
		
		createRegisterOfeWire($isOffline)
		
		clearInvoiceEnterableVars
		
		If (getClientAutoeWirePrint)
			// need to force user to save the invoice
			confirmPrinteWire
		End if 
		
		
		If ([eWires:13]BeneficiaryEmail:63#"")
			//sendEmail
		End if 
		
		[eWires:13]SenderName:7:=[Customers:3]FullName:40
		[eWires:13]senderAddress:96:=[Customers:3]Address:7
		[eWires:13]senderCity:98:=[Customers:3]City:8
		[eWires:13]senderPhone:97:=[Customers:3]HomeTel:6
		[eWires:13]senderPostalCode:100:=[Customers:3]PostalCode:10
		[eWires:13]senderState:99:=[Customers:3]Province:9
		[eWires:13]senderDOB:101:=[Customers:3]DOB:5
		[eWires:13]senderEmail:102:=[Customers:3]Email:17
		[eWires:13]senderGovernmentID:103:=[Customers:3]PictureID_Number:69
		[eWires:13]senderGovernmentIDType:104:=[Customers:3]PictureID_Type:70
		
		vAML_POT:=[eWires:13]PurposeOfTransaction:65
		vAML_SOF:=[eWires:13]AMLsourceOfFunds:94
		
		
		//did this come from an webEwire?
		If ([eWires:13]WebEwireID:123#"")
			C_OBJECT:C1216($entity; $we)
			C_TEXT:C284($comment)
			$entity:=ds:C1482.WebEWires.query("WebEwireID == :1"; [eWires:13]WebEwireID:123)
			If ($entity.length=1)
				//check poliPay status and if paid create line item 2 register
				$we:=$entity.first()
				
				If (OB Get type:C1230($we; "paymentInfo")=Is null:K8:31)
				Else 
					$currErr:=Method called on error:C704
					ON ERR CALL:C155("errorIgnore")
					
					If (OB Is defined:C1231($we.paymentInfo))
						If ($we.paymentInfo.poliStatus="Completed")  //this has been paid so ok to create register
							C_TEXT:C284($depAccount)
							$depAccount:=getKeyValue("web.configuration.payments.depositaccount.poli")
							
							If ($depAccount="")  //don't create - make user create
							Else 
								CREATE RECORD:C68([AccountInOuts:37])
								
								[AccountInOuts:37]AccountInOutID:1:=makeAccountInOutID
								[AccountInOuts:37]CustomerID:2:=[Invoices:5]CustomerID:2
								[AccountInOuts:37]Date:3:=[Invoices:5]invoiceDate:44
								[AccountInOuts:37]InvoiceID:4:=[Invoices:5]InvoiceID:1
								[AccountInOuts:37]AccountID:6:=$depAccount  //get keyvalue here
								[AccountInOuts:37]Amount:7:=$we.fromAmount  //<>TODO check with Tiran
								[AccountInOuts:37]feeLocal:16:=0  //$we.fromFee  //fee was collected via the ewire side
								[AccountInOuts:37]Currency:8:=$we.fromCCY  //currenlty will always be base currency
								[AccountInOuts:37]isPaid:9:=False:C215
								[AccountInOuts:37]BranchID:18:=getBranchID
								[AccountInOuts:37]ReferenceNo:22:=Substring:C12($we.paymentInfo.gateway; 1; 4)+$we.paymentInfo.TransactionRefNo
								[AccountInOuts:37]amountLocal:17:=[AccountInOuts:37]Amount:7-[AccountInOuts:37]feeLocal:16  // (amount *rate +-fee = localAmt is the receivable
								[AccountInOuts:37]ourRate:13:=1
								
								
								$comment:=$we.paymentInfo.gateway+": "+$we.paymentInfo.TransactionRefNo+CRLF
								$comment:=$comment+" Bank receipt: "+$we.paymentInfo.BankReceiptNo+CRLF
								$comment:=$comment+" Bank date time: "+$we.paymentInfo.BankReceiptDateTime+CRLF
								$comment:=$comment+" Amount paid: "+String:C10($we.paymentInfo.AmountPaid; "###,###,##0.00")+CRLF
								$comment:=$comment+" Completion Time: "+$we.paymentInfo.CompletionTime+CRLF
								[AccountInOuts:37]autoComment:12:=$comment
								
								createRegisterOfAccountInOuts
								SAVE RECORD:C53([AccountInOuts:37])
							End if 
						End if 
					End if 
				End if 
				
				ON ERR CALL:C155($currErr)
				
			End if 
		End if 
		
	End if 
	
	
	If ([eWires:13]WebEwireID:123#"")
		[eWires:13]Status:22:=getEwireStatus  //need to change prior to save so we can test  OLD
		createOnChangeNotification(->[eWires:13])  //11/17/20 IBB for webewires -
	End if 
	
	SAVE RECORD:C53([eWires:13])  //must come after notification
	
	ACCEPT:C269
Else 
	REJECT:C38
End if 