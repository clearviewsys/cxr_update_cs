//%attributes = {}

C_TEXT:C284($1; $objName)
C_TEXT:C284($2; $keyword)



C_TEXT:C284($tmp)
C_LONGINT:C283($from; $to)

Case of 
		
	: (Count parameters:C259=1)
		
		$objName:=$1
		$keyword:="*MISSING*"
		
	: (Count parameters:C259=2)
		
		$objName:=$1
		$keyword:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$to:=1
$tmp:=""

Repeat 
	
	$from:=Position:C15($keyword; ST Get text:C1116(*; $objName); $to)
	$to:=$from+Length:C16($keyword)
	
	If ($from>0)
		ST SET ATTRIBUTES:C1093(*; $objName; $from; $to; Attribute text color:K65:7; "Red")
	End if 
	
	
Until ($from<=0)

