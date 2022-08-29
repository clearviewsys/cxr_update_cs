//%attributes = {}
Case of 
	: (Form event code:C388=On Load:K2:1)
		// Set visible the button "Bank Info" if key value is ON
		setVisibleIff(getKeyValue("Quick.Bank.Info.Enabled"; "NO")="YES"; "bBankInfo")
		
	: (Form event code:C388=On Clicked:K2:4)
		// Open dialog to enter and validate the information
		
		C_LONGINT:C283($winRef)
		C_TEXT:C284(vBankName; vAccountNo; vAccountName; vSwift)
		C_BOOLEAN:C305(updatewt)
		updatewt:=False:C215
		
		vBankName:=""
		vAccountNo:=""
		vAccountName:=[Customers:3]FullName:40
		vSwift:=""
		
		READ WRITE:C146([WireTemplates:42])
		QUERY:C277([WireTemplates:42]; [WireTemplates:42]WireTemplateID:1=[AccountInOuts:37]WireTemplateID:27)
		
		If (Records in selection:C76([WireTemplates:42])=1)
			updatewt:=True:C214
			vAccountNo:=[WireTemplates:42]AccountNo:6
			vBankName:=[WireTemplates:42]BankName:3
			vAccountName:=[WireTemplates:42]BeneficiaryFullName:9
			vSwift:=[WireTemplates:42]SWIFT:8
			
		End if 
		
		
		$winRef:=Open form window:C675("BankInfo"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4)
		DIALOG:C40("BankInfo")
		CLOSE WINDOW:C154
		
End case 
