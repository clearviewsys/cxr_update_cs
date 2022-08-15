//%attributes = {}
// sets help tips in mgSend and mgReceive forms
C_OBJECT:C1216($1; $transactionObject)
C_LONGINT:C283($i)
C_TEXT:C284($currHelpTip)

$transactionObject:=$1

ARRAY TEXT:C222($properties; 0)

OB GET PROPERTY NAMES:C1232($transactionObject.object; $properties)

For ($i; 1; Size of array:C274($properties))
	
	$currHelpTip:=""
	
	If ($transactionObject.mandatory[$properties{$i}])
		$currHelpTip:="Mandatory"
	End if 
	
	If ($transactionObject.maxminlen[$properties{$i}]#"")
		If ($currHelpTip="")
			$currHelpTip:="Min. length/Max. length: "+$transactionObject.maxminlen[$properties{$i}]
		Else 
			$currHelpTip:=$currHelpTip+", "+"Min. length/Max. length: "+$transactionObject.maxminlen[$properties{$i}]
		End if 
	End if 
	
	If ($transactionObject.masks[$properties{$i}]#"")
		If ($currHelpTip="")
			$currHelpTip:="Mask: "+$transactionObject.masks[$properties{$i}]
		Else 
			$currHelpTip:=$currHelpTip+", "+"Mask: "+$transactionObject.masks[$properties{$i}]
		End if 
		
	End if 
	
	OBJECT SET HELP TIP:C1181(*; $properties{$i}; $currHelpTip)
	
End for 

