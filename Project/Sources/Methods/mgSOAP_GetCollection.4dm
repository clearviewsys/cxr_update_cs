//%attributes = {}
// return collection of fields which MoneyGram returned as XML via SOAP API

C_TEXT:C284($1; $root)
C_COLLECTION:C1488($0)
C_OBJECT:C1216($rootObj; $foundRecords)
C_LONGINT:C283($type)

$root:=DOM Parse XML variable:C720($1)

If (OK=1)
	
	$rootObj:=mgXML2Object($root)
	DOM CLOSE XML:C722($root)
	
	$foundRecords:=mgGetSubObject($rootObj; "FoundRecords")
	
	If ($foundRecords#Null:C1517)
		
		If ($foundRecords.ArrayOfField#Null:C1517)
			
			$type:=Value type:C1509($foundRecords.ArrayOfField)
			
			Case of 
					
				: ($type=Is collection:K8:32)
					$0:=$foundRecords.ArrayOfField
					
				: ($type=Is object:K8:27)  // When there is only one record returned, ArrayOfField is object, not collection, fix the result so it is always the collection
					
					If ($foundRecords.ArrayOfField.Field#Null:C1517)
						$0:=New collection:C1472
						$0.push($foundRecords.ArrayOfField)
					End if 
					
				Else 
					// shouldn't happen
			End case 
		End if 
	End if 
	
End if 
