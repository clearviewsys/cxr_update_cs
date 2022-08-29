//%attributes = {}
// handleTriState_DateUserStamp (->tristate; ->date; ->user; formEvent)
// use this helper method where you have a tristate checkbox when checked, you
// need to datestamp and user stamp 

C_POINTER:C301($triStateCheckboxPtr; $1)
C_POINTER:C301($datePtr; $2)
C_POINTER:C301($userPtr; $3)
C_LONGINT:C283($formEvent; $4)

Case of 
	: (Count parameters:C259=3)
		$triStateCheckboxPtr:=$1
		$datePtr:=$2
		$userPtr:=$3
		$formEvent:=On Clicked:K2:4
		
	: (Count parameters:C259=4)
		$triStateCheckboxPtr:=$1
		$datePtr:=$2
		$userPtr:=$3
		$formEvent:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (Form event code:C388=$formEvent)
	Case of 
		: ($triStateCheckboxPtr->=0)
			$datePtr->:=!00-00-00!
			$userPtr->:=""
		Else 
			$datePtr->:=Current date:C33
			$userPtr->:=getApplicationUser
	End case 
End if 