//%attributes = {}
// handleAccountTypeDropDown (->arrDropDown)
// form events: on load/ on clicked / on outside call

C_LONGINT:C283($i; $n)
C_TEXT:C284($localized)
C_POINTER:C301($dropDownPtr; $1)
C_POINTER:C301($accountTypePtr; $2)

Case of 
	: (Count parameters:C259=0)
		ARRAY TEXT:C222(arrAccountType; 6)
		$dropDownPtr:=->arrAccountType
		$accountTypePtr:=->[MainAccounts:28]AccountType:4
		
	: (Count parameters:C259=1)
		$dropDownPtr:=$1
		$accountTypePtr:=->[MainAccounts:28]AccountType:4
		
	: (Count parameters:C259=2)
		$dropDownPtr:=$1
		$accountTypePtr:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (Form event code:C388=On Load:K2:1)
	LIST TO ARRAY:C288("AccountTypes"; $dropDownPtr->)
	$n:=Size of array:C274($dropDownPtr->)
	For ($i; 1; $n)
		$dropDownPtr->{$i}:=getLocalizedKeyword($dropDownPtr->{$i})
	End for 
	
	If (Is new record:C668([MainAccounts:28]))
		$dropDownPtr->:=0
	Else 
		$dropDownPtr->:=$accountTypePtr->
	End if 
End if 

If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	$accountTypePtr->:=$dropDownPtr->  // the index should 
End if 