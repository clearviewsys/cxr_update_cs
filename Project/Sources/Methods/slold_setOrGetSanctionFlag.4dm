//%attributes = {}
// set or get the sanction flag, uses either code 
// Author: Wai-Kin
// Unit test is written @ Wai-Kin

C_POINTER:C301($1; $current)
C_VARIANT:C1683($2; $input)
C_REAL:C285($3; $value)
C_LONGINT:C283($flag)
C_BOOLEAN:C305($isSetting)
C_BOOLEAN:C305($0)

Case of 
	: (Count parameters:C259=2)
		$current:=$1
		$input:=$2
		$value:=0
		$isSetting:=False:C215
	: (Count parameters:C259=3)
		$current:=$1
		$input:=$2
		$value:=$3
		$isSetting:=True:C214
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (Value type:C1509($input)=Is text:K8:3)
	C_LONGINT:C283($load)
	$load:=Load list:C383("SanctionListFlags")
	ARRAY TEXT:C222($flags; 0)
	LIST TO ARRAY:C288($load; $flags)
	$flag:=Find in array:C230($flags; $input)
	ASSERT:C1129($flag#-1; "Flag not found:"+$input)
	$flag:=$flag-1
Else 
	If (Value type:C1509($input)=Is real:K8:4)
		$flag:=$input
	End if 
End if 

If ($isSetting)
	Case of 
		: ($value=1)
			$current->:=($current->) ?+ $flag
		: ($value=-1)
			$current->:=($current->) ?- $flag
		Else 
			If ($current-> ?? $flag)
				$current->:=($current->) ?- $flag
			Else 
				$current->:=($current->) ?+ $flag
			End if 
	End case 
End if 
$0:=$current-> ?? $flag
