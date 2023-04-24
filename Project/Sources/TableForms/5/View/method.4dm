// form method invoice entry

//C_REAL(vTotalReceived;vTotalPaid;vRemainPaid;vRemainReceive)  ` balance variables
C_PICTURE:C286(vFromFlag; vToFlag)  // flags
C_REAL:C285(vCrossExchangeRate)
C_REAL:C285(vFromAmount; vTotalReceived; vRemainPaid; vToAmount; vTotalPaid)
C_BOOLEAN:C305($showTPartyButton)

//handleCalculatorFormMethod 

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11))
	C_REAL:C285(vAmount)
	READ ONLY:C145([Customers:3])
	READ ONLY:C145([Registers:10])
	READ ONLY:C145([Accounts:9])
	READ ONLY:C145([IM_TransferLog:133])
	
	UNLOAD RECORD:C212([Customers:3])
	RELATE ONE:C42([Invoices:5]CustomerID:2)
	
	UNLOAD RECORD:C212([IM_TransferLog:133])
	RELATE MANY:C262([IM_TransferLog:133]RegisterID:2)
	
	//************* BEGIN:  DO NOT CHANGE THE ORDER
	setInvoiceVarsToFields
	relateManyRegistersForInvoice
	// ************** END: DO NOT CHANGE ORDER ****** 
	RELATE ONE:C42([Invoices:5]TransactionTypeID:91)
	
End if 


//
hideObjectsOnTrue(([Invoices:5]suspiciousNotes:31=""); "suspicious@")
stampText("stamp_flag"; "🚩"; "red"; [Invoices:5]isFlagged:41)
stampText("stamp_cancelled"; "Cancelled ✖"; "red"; [Invoices:5]isCancelled:84)
stampText("stamp_suspicious"; "Suspicious ☢️"; "red"; [Invoices:5]isSuspicious:30)

// Show the Third party Button or the message related to third party involved.

READ ONLY:C145([ThirdParties:101])
QUERY:C277([ThirdParties:101]; [ThirdParties:101]InvoiceID:30=[Invoices:5]InvoiceID:1)

If (([Invoices:5]didAskIfThirdPartyIsInvolved:96=True:C214) & ([Invoices:5]ThirdPartyisInvolved:22=False:C215))
	ThirdPartyMsg:="Third Party Not Involved"
	hideObjectsOnTrue(True:C214; "bThirdParty")
Else 
	If (([Invoices:5]didAskIfThirdPartyIsInvolved:96=True:C214) & ([Invoices:5]ThirdPartyisInvolved:22=True:C214))
		ThirdPartyMsg:=""
		hideObjectsOnTrue(True:C214; "ThirdPartyMsg")
		hideObjectsOnTrue(False:C215; "bThirdParty")
	Else 
		ThirdPartyMsg:=""
		hideObjectsOnTrue(True:C214; "ThirdPartyMsg")
	End if 
End if 

// Display IdentityMind
If (getKeyValue("identityMind.activated")#"true")
	OBJECT SET VISIBLE:C603(*; "b_identityMind"; False:C215)
Else 
	IM_preformTransferRelatedTasks("initalize")
End if 


// Show/Hide signature button according if exists or not.
READ ONLY:C145([Signatures:141])
QUERY:C277([Signatures:141]; [Signatures:141]InvoiceNumber:2=[Invoices:5]InvoiceID:1)

If (Records in selection:C76([Signatures:141])=1)
	hideObjectsOnTrue(False:C215; "b_Signature")
Else 
	hideObjectsOnTrue(True:C214; "b_Signature")
End if 


handleViewForm
