//%attributes = {}
// Builds HTML code to be displayed in hidden Web Area in a form that 
// we submit to MoneyGram to send the data about transaction we want to initiate

C_TEXT:C284($0; $currValue)
C_OBJECT:C1216($1; $sendObject)
C_LONGINT:C283($i; $type)

$sendObject:=$1
$0:=""

ARRAY TEXT:C222($propertyNames; 0)

OB GET PROPERTY NAMES:C1232($sendObject; $propertyNames)

For ($i; 1; Size of array:C274($propertyNames))
	
	$type:=OB Get type:C1230($sendObject; $propertyNames{$i})
	
	Case of 
			
		: ($type=Is text:K8:3)
			
			$currValue:=$sendObject[$propertyNames{$i}]
			
			
		: ($type=Is date:K8:7)
			
			$currValue:=mgGetProfixDate($sendObject[$propertyNames{$i}])
			
			
		: ($type=Is real:K8:4)
			
			$currValue:=mgGetProfixReal($sendObject[$propertyNames{$i}])
			
	End case 
	
	$0:=$0+$propertyNames{$i}+": <input type="+Char:C90(Double quote:K15:41)+"text"+Char:C90(Double quote:K15:41)+" name="+Char:C90(Double quote:K15:41)+$propertyNames{$i}+Char:C90(Double quote:K15:41)
	$0:=$0+" value="+Char:C90(Double quote:K15:41)+$currValue+Char:C90(Double quote:K15:41)+" id="+Char:C90(Double quote:K15:41)+$propertyNames{$i}+Char:C90(Double quote:K15:41)
	$0:=$0+" readonly><br>\n"
	
End for 
