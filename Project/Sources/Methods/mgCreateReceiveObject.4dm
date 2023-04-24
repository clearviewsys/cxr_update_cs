//%attributes = {"shared":true}
C_COLLECTION:C1488($definitionColl)
C_OBJECT:C1216($0; $receiveObject; $oneProperty)

$definitionColl:=mgDefineReceiveObject

$receiveObject:=New object:C1471
$receiveObject.object:=New object:C1471
$receiveObject.masks:=New object:C1471
$receiveObject.mandatory:=New object:C1471
$receiveObject.maxminlen:=New object:C1471

For each ($oneProperty; $definitionColl)
	
	If ($oneProperty.mask#Null:C1517)
		$receiveObject.masks[$oneProperty.name]:=$oneProperty.mask
	End if 
	
	$receiveObject.mandatory[$oneProperty.name]:=False:C215
	If ($oneProperty.required#Null:C1517)
		If ($oneProperty.required="yes")
			$receiveObject.mandatory[$oneProperty.name]:=True:C214
		End if 
	End if 
	
	If ($oneProperty.minmaxlen#Null:C1517)
		$receiveObject.maxminlen[$oneProperty.name]:=$oneProperty.minmaxlen
	End if 
	
	If ($oneProperty.value#Null:C1517)
		
		$receiveObject.object[$oneProperty.name]:=$oneProperty.value
		
	Else 
		
		Case of 
				
			: ($oneProperty.type="string")
				
				$receiveObject.object[$oneProperty.name]:=""
				
				
			: ($oneProperty.type="real")
				
				$receiveObject.object[$oneProperty.name]:=0
				
				
			: ($oneProperty.type="date")
				
				$receiveObject.object[$oneProperty.name]:=!00-00-00!
				
		End case 
		
	End if 
	
End for each 

$0:=$receiveObject
