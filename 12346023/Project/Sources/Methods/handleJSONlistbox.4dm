//%attributes = {}
// handleJSONlistbox($object)
// Author: Wai-Kin

C_COLLECTION:C1488($columns; $0)
C_OBJECT:C1216($object; $1)

Case of 
	: (Count parameters:C259=1)
		$object:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_COLLECTION:C1488($stack)
$stack:=New collection:C1472
$stack.push(New object:C1471("parent"; ""; "target"; $object))

$columns:=New collection:C1472

C_TEXT:C284($key)
While ($stack.length#0)
	C_OBJECT:C1216($pointer)
	$pointer:=$stack.pop()
	C_TEXT:C284($parent)
	$parent:=$pointer.parent
	
	If (OB Get type:C1230($pointer; "target")=Is collection:K8:32)
		C_COLLECTION:C1488($collection)
		$collection:=$pointer.target
		C_LONGINT:C283($i)
		For ($i; 0; $collection.length-1)
			C_TEXT:C284($child)
			$child:=$parent+String:C10($i)+"]"
			Case of 
				: (Value type:C1509($collection[$i])=Is object:K8:27)
					$stack.push(New object:C1471("parent"; $child+"▶"; "target"; $collection[$i]))
				: (Value type:C1509($collection[$i])=Is collection:K8:32)
					$stack.push(New object:C1471("parent"; $child+"]["; "target"; $collection[$i]))
				: (Value type:C1509($collection[$i])=Is null:K8:31)
				Else 
					If (String:C10($collection[$i])#"")
						$columns.push(New object:C1471("name"; $child; "value"; String:C10($collection[$i])))
					End if 
			End case 
		End for 
		//$i:=0
		//For each ($item;$collection)
		//C_TEXT($child)
		//$child:=$parent+String($i)+"]"
		//Case of 
		//: (Value type($item)=Is object)
		//$stack.push(New object("parent";$child+"▶";"target";$item))
		//: (Value type($item)=Is collection)
		//$stack.push(New object("parent";$child+"][";"target";$item))
		//: (Value type($item)=Is null)
		//Else 
		//If (String($item)#"")
		//$columns.push(New object("name";$child;"value";String($item)))
		//End if 
		//End case 
		//$i:=$i+1
		//End for each 
		
	Else 
		C_OBJECT:C1216($value)
		C_TEXT:C284($name)
		$value:=$pointer.target
		If ($value#Null:C1517)
			For each ($name; $value)
				Case of 
					: (OB Get type:C1230($value; $name)=Is null:K8:31)
					: (OB Get type:C1230($value; $name)=Is collection:K8:32)
						C_TEXT:C284($child)
						$child:=$parent+$name+"["
						$stack.push(New object:C1471("parent"; $child; "target"; $value[$name]))
					: (OB Get type:C1230($value; $name)=Is object:K8:27)
						C_TEXT:C284($child)
						$child:=$parent+$name+"▶"
						$stack.push(New object:C1471("parent"; $child; "target"; $value[$name]))
					Else 
						If (String:C10($value[$name])#"")
							$columns.push(New object:C1471("name"; $parent+$name; "value"; $value[$name]))
						End if 
				End case 
			End for each 
		End if 
	End if 
End while 
$columns:=$columns.orderBy("name asc")
$0:=$columns