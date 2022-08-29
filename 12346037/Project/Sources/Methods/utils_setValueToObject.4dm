//%attributes = {}
//! #brief sets a value 
//! #author Wai-Kin Chau
//unit test is written 
var $1; $input : Object
var $2; $value : Variant
var $0; $output : Object
var ${3} : Text  //! property keys

Case of 
	: (Count parameters:C259>=3)
		$input:=$1
		$value:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

var $child : Object
$child:=$input
$output:=$input

If (Not:C34(OB Is defined:C1231($child)))
	$child:=New object:C1471
	$output:=$child
End if 

var $i : Real
For ($i; 3; Count parameters:C259-1)
	If (Not:C34(OB Is defined:C1231($child; ${$i})))
		$child[${$i}]:=New object:C1471
	End if 
	$child:=$child[${$i}]
End for 
$child[${Count parameters:C259}]:=$value

$0:=$output


