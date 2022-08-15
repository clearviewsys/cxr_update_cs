//%attributes = {}
// handleInvoiceThirdParty

Case of 
	: (Form event code:C388=On Load:K2:1)
		setVisibleIff(False:C215; "ThirdPartyIsInvolved_l")
		setVisibleIff(False:C215; "ThirdPartyIsInvolved")
		setVisibleIff(False:C215; "bThirdParty")
		[Invoices:5]didAskIfThirdPartyIsInvolved:96:=False:C215
		REDUCE SELECTION:C351([ThirdParties:101]; 0)
		
		If ([Invoices:5]ThirdPartyisInvolved:22)
			// Get third parties related information
			QUERY:C277([ThirdParties:101]; [ThirdParties:101]InvoiceID:30=[Invoices:5]InvoiceID:1)
			
			[Invoices:5]didAskIfThirdPartyIsInvolved:96:=True:C214
			setVisibleIff([Invoices:5]ThirdPartyisInvolved:22; "ThirdPartyIsInvolved_l")
			setVisibleIff([Invoices:5]ThirdPartyisInvolved:22; "ThirdPartyIsInvolved")
			setVisibleIff([Invoices:5]ThirdPartyisInvolved:22; "bThirdParty")
		Else 
			
			If (Is new record:C668([Invoices:5]))
				[Invoices:5]didAskIfThirdPartyIsInvolved:96:=False:C215
				setVisibleIff(False:C215; "ThirdPartyIsInvolved_l")
				setVisibleIff(False:C215; "ThirdPartyIsInvolved")
				setVisibleIff(False:C215; "bThirdParty")
			Else 
				
				[Invoices:5]didAskIfThirdPartyIsInvolved:96:=True:C214
				setVisibleIff(True:C214; "ThirdPartyIsInvolved_l")
				setVisibleIff(True:C214; "ThirdPartyIsInvolved")
				setVisibleIff(False:C215; "bThirdParty")
			End if 
			
		End if 
		
End case 


