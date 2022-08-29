//%attributes = {}
C_TEXT:C284($0)
C_POINTER:C301($tablePtr; $fieldPtr; $1; $2)

C_TEXT:C284($result; $operator; $booleanOp; $stringvalue; $3; $4; $5)
C_LONGINT:C283($iType)


Case of 
	: (Count parameters:C259=1)
		
	: (Count parameters:C259=3)
		$tablePtr:=$1
		$fieldPtr:=$2
		$stringValue:=$3
		$operator:="="
		
	: (Count parameters:C259=4)
		$tablePtr:=$1
		$fieldPtr:=$2
		$stringValue:=$3
		$operator:=$4
		
		
	: (Count parameters:C259=5)
		$tablePtr:=$1
		$fieldPtr:=$2
		$stringValue:=$3
		$operator:=$4  // = , >= , <=
		$booleanOp:=$5  // e.g: AND OR
		
	Else 
		$tablePtr:=->[eWires:13]
		$fieldPtr:=->[eWires:13]fromCountry:9
		$stringValue:="NEW ZEALAND"
		$operator:="="
End case 


$iType:=Type:C295($fieldPtr->)

Case of 
	: ($iType=Is boolean:K8:9)
		$result:=Table name:C256($tablePtr)+"."+Field name:C257($fieldPtr)+$operator+" "+$stringValue
		
	: ($iType=Is real:K8:4) | ($iType=Is longint:K8:6) | ($iType=Is integer:K8:5)
		$result:=Table name:C256($tablePtr)+"."+Field name:C257($fieldPtr)+$operator+" "+$stringValue
		
	Else 
		$result:=Table name:C256($tablePtr)+"."+Field name:C257($fieldPtr)+$operator+Char:C90(Quote:K15:44)+($stringValue)+Char:C90(Quote:K15:44)
End case 


If ($booleanOp#"")
	$result:=$result+" "+$booleanOp+CRLF
End if 

$0:=$result