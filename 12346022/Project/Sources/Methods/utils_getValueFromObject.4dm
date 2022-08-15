//%attributes = {}
/** gets a value from an object or se the default value

Author: Wai-Kin
Unit test is written by @Wai-Kin
*/
var $1; $input : Object
var $2; $default : Variant
var $0; $value : Variant
var ${3} : Text  //! property keys

Case of 
	: (Count parameters:C259>=3)
		$input:=$1
		$default:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (OB Is defined:C1231($input))
	var $pointer : Object
	$pointer:=$input
	
	var $i : Integer
	$i:=3
	
	var $findKey : Boolean
	$findKey:=True:C214
	
	For ($i; 3; Count parameters:C259)
		If (OB Is defined:C1231($pointer; ${$i}))
			$value:=$pointer[${$i}]
			If ((Value type:C1509($pointer[${$i}]))=Is object:K8:27)
				$pointer:=$pointer[${$i}]
			Else 
				$findKey:=$i=Count parameters:C259
				$i:=Count parameters:C259
			End if 
		Else 
			$findKey:=False:C215
			$i:=Count parameters:C259
		End if 
	End for 
	
	If ($findKey)
		If (Value type:C1509($default)=Is null:K8:31)
			If (Value type:C1509($value)#Is pointer:K8:14)
				$value:=$default
			End if 
		Else 
			If (Value type:C1509($value)#Value type:C1509($default))
				$value:=$default
			End if 
		End if 
	Else 
		$value:=$default
	End if 
Else 
	$value:=$default
End if 

$0:=$value