//%attributes = {}
// Set the value only if there is no value with that key
// Author: Wai-Kin
#DECLARE($objectParam : Object; $valueParam : Variant)->$objectChanged : Boolean

var $object : Object
var $value : Variant

Case of 
	: (Count parameters:C259>=2)
		$object:=$objectParam
		$value:=$valueParam
End case 

var ${3} : Text  //! object keys
$objectChanged:=False:C215

If (Not:C34(OB Is defined:C1231($object)))
	$object:=New object:C1471
	$objectChanged:=True:C214
End if 
var $child : Object
$child:=$object

var $i : Integer
For ($i; 3; Count parameters:C259-1)
	If (Not:C34(OB Is defined:C1231($child; ${$i})))
		$child[${$i}]:=New object:C1471
		$objectChanged:=True:C214
	End if 
	$child:=$child[${$i}]
End for 
If (Not:C34(OB Is defined:C1231($child; ${Count parameters:C259})))
	$child[${Count parameters:C259}]:=$value
	$objectChanged:=True:C214
End if 
