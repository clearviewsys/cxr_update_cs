//%attributes = {}
// handleInvoiceThirdPartyCheckbox (->triStateCheckbox; buttonObject)
// this method handles the 'Third Party' state in an invoice. 



C_POINTER:C301($self; $1)
C_TEXT:C284($buttonObject; $2)
C_LONGINT:C283($isThirdParty_num)
C_LONGINT:C283($triStatecheckboxState)

Case of 
	: (Count parameters:C259=0)
		$self:=Self:C308
	: (Count parameters:C259=1)
		$self:=$1
		$buttonObject:="b_ThirdPartyDetails"
	: (Count parameters:C259=2)
		$self:=$1
		$buttonObject:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$triStatecheckboxState:=$self->

If (Form event code:C388=On Load:K2:1)
	C_BOOLEAN:C305($didAsk; $isInvolved)
	$didAsk:=[Invoices:5]didAskIfThirdPartyIsInvolved:96
	$isInvolved:=[Invoices:5]ThirdPartyisInvolved:22
	
	Case of 
		: (($didAsk=False:C215) & ($isInvolved=False:C215))  // didn't ask, no answer
			$isThirdParty_num:=0
			
		: (($didAsk=False:C215) & ($isInvolved=True:C214))  // didn't ask; but answer was true (impossible state)
			//ASSERT(False;"This state is not valid")
			writeLog("assertion failure: handleInvoidThirdPartyCheckbox; invalid state didn't ask if third party involved, but the answer is true")
			
			$isThirdParty_num:=1
			
		: (($didAsk=True:C214) & ($isInvolved=False:C215))  // did ask; answer was negative
			$isThirdParty_num:=2
			
		: (($didAsk=True:C214) & ($isInvolved=True:C214))  // did ask; answer was positive (third party was involved)
			$isThirdParty_num:=1
			
	End case 
End if 

handleTristateCheckBox($self; ->$isThirdParty_num; "Is this on behalf of a 3rd party?"; "Positive: 3rd Party Involved!"; "3rd Parties NOT Involved"; Black:K11:16; Red:K11:4; Blue:K11:7)

If (Form event code:C388=On Clicked:K2:4)
	Case of 
		: ($triStatecheckboxState=0)  // no-state
			[Invoices:5]didAskIfThirdPartyIsInvolved:96:=False:C215
			[Invoices:5]ThirdPartyisInvolved:22:=False:C215
			
		: ($triStatecheckboxState=1)  // yes-state
			[Invoices:5]didAskIfThirdPartyIsInvolved:96:=True:C214
			[Invoices:5]ThirdPartyisInvolved:22:=True:C214
			
		: ($triStatecheckboxState=2)  // mix-state
			[Invoices:5]didAskIfThirdPartyIsInvolved:96:=True:C214
			[Invoices:5]ThirdPartyisInvolved:22:=False:C215
	End case 
End if 

setVisibleIff(($triStatecheckboxState=1); $buttonObject)