//%attributes = {}
// return object MoneyGram returned as XML via 
// call to SendRequest SOAP API method

C_TEXT:C284($1; $root)
C_OBJECT:C1216($0)
C_OBJECT:C1216($rootObj; $foundRecords; $property)
C_LONGINT:C283($type)

$root:=DOM Parse XML variable:C720($1)

If (OK=1)
	
	$rootObj:=mgXML2Object($root)
	DOM CLOSE XML:C722($root)
	
	$foundRecords:=mgGetSubObject($rootObj; "SendRequestResult")
	
	If ($foundRecords#Null:C1517)
		
		$0:=New object:C1471
		
		For each ($property; $foundRecords.Field)
			$0[$property.Name]:=$property.Value
		End for each 
		
	End if 
	
End if 
