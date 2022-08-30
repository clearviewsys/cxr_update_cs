//%attributes = {}
C_OBJECT:C1216($0; $rootObj; $foundRecords)
C_TEXT:C284($1; $root)
C_TEXT:C284($2; $action)
C_LONGINT:C283($i)

$root:=DOM Parse XML variable:C720($1)
$action:=$2+"Result"

If (OK=1)
	
	$rootObj:=mgXML2Object($root)
	DOM CLOSE XML:C722($root)
	
	$foundRecords:=mgGetSubObject($rootObj; $action)
	
	If ($foundRecords#Null:C1517)
		
		If ($foundRecords.Field#Null:C1517)
			
			If ($foundRecords.Field.length>0)
				
				$0:=New object:C1471
				
				For ($i; 1; $foundRecords.Field.length)
					
					$0[$foundRecords.Field[$i-1].Name]:=$foundRecords.Field[$i-1].Value
					
				End for 
				
			End if 
			
		End if 
		
	End if 
	
	
End if 

