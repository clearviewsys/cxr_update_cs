//%attributes = {"shared":true}
// creates send object based on MoneyGram Send Object definition

C_COLLECTION:C1488($definitionColl)
C_OBJECT:C1216($0; $sendObject; $oneProperty)

$definitionColl:=mgDefineSendObject

$sendObject:=New object:C1471
$sendObject.object:=New object:C1471
$sendObject.masks:=New object:C1471
$sendObject.mandatory:=New object:C1471
$sendObject.maxminlen:=New object:C1471

For each ($oneProperty; $definitionColl)
	
	If ($oneProperty.mask#Null:C1517)
		$sendObject.masks[$oneProperty.name]:=$oneProperty.mask
	End if 
	
	$sendObject.mandatory[$oneProperty.name]:=False:C215
	If ($oneProperty.required#Null:C1517)
		If ($oneProperty.required="yes")
			$sendObject.mandatory[$oneProperty.name]:=True:C214
		End if 
	End if 
	
	If ($oneProperty.minmaxlen#Null:C1517)
		$sendObject.maxminlen[$oneProperty.name]:=$oneProperty.minmaxlen
	End if 
	
	If ($oneProperty.value#Null:C1517)
		
		$sendObject.object[$oneProperty.name]:=$oneProperty.value
		
	Else 
		
		Case of 
				
			: ($oneProperty.type="string")
				
				$sendObject.object[$oneProperty.name]:=""
				
				
			: ($oneProperty.type="real")
				
				$sendObject.object[$oneProperty.name]:=0
				
				
			: ($oneProperty.type="date")
				
				$sendObject.object[$oneProperty.name]:=!00-00-00!
				
		End case 
		
	End if 
	
End for each 

$0:=$sendObject
