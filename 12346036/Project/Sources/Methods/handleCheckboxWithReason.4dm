//%attributes = {}
// handleCheckBoxWithReason(->fieldPtr; ->reasonField)
// validateCustomers

C_TEXT:C284($reason)
C_POINTER:C301($booleanFieldPtr; $1; $reasonPtr; $2)
C_LONGINT:C283($formEvent; $3)

Case of 
	: (Count parameters:C259=2)
		$booleanFieldPtr:=$1
		$reasonPtr:=$2
		$formEvent:=On Clicked:K2:4
		
	: (Count parameters:C259=3)
		$booleanFieldPtr:=$1
		$reasonPtr:=$2
		$formEvent:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (Form event code:C388=$formEvent)
	If ($booleanFieldPtr->#Old:C35($booleanFieldPtr->))
		Repeat 
			$reason:=myRequest("Please describe Reason for this change:")
		Until ($reason#"")
		
		If (OK=1)
			$reasonPtr->:=$reason
		End if 
	End if 
End if 