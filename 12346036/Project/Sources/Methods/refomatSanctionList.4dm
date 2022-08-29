//%attributes = {}
// reformatSanctionList($item)
//
// Change {"property"="data"} to {"key="property","value"="data"} and break up Otherinfo.
//
// Parameter
// $item (C_Collection)
//    The collection of item whose property need to be reformated
//
// Return: (C_OBJECT)
//    The reformatted result (see checkInputToSanctionLists.list for format)

C_OBJECT:C1216($0; $item)
C_OBJECT:C1216($1; $rawItem)

Case of 
	: (Count parameters:C259=1)
		$rawItem:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$item:=New object:C1471
$item.properties:=New collection:C1472
C_TEXT:C284($rawProp)
C_TEXT:C284($rawValue)

For each ($rawProp; $rawItem)
	If (OB Get:C1224($rawItem; $rawProp)#Null:C1517)
		$rawValue:=OB Get:C1224($rawItem; $rawProp)
		
		C_OBJECT:C1216($property)
		
		If ($rawProp="Otherinfo")
			C_OBJECT:C1216($child)
			C_TEXT:C284($childProp)
			$child:=splitTextToObject($rawValue; ": "; ", \n")
			For each ($childProp; $child)
				$property:=New object:C1471
				$property.key:=$childProp
				$property.value:=OB Get:C1224($child; $childProp)
				$property.style:=Plain:K14:1
				$property.color:=lk inherited:K53:26
				$item.properties.push($property)
			End for each 
			
		Else 
			If ($rawValue#"")
				$property:=New object:C1471
				$property.key:=$rawProp
				$property.value:=$rawValue
				$property.style:=Plain:K14:1
				Case of 
					: ($property.key="ListId")
						$property.color:=0x00808080
					: ($property.key="ListName")
						$property.color:=0x00808080
					: ($property.key="Matchtype")
						$property.color:=0x00808080
						Case of 
							: (Position:C15("EXACT"; $property.value)>0)
								$item.type:="EXACT"
							: (Position:C15("SIMILAR"; $property.value)>0)
								$item.type:="SIMILAR"
						End case 
					: ($property.key="Fullname")
						$property.style:=Bold:K14:2
						$property.color:=0x0000
						$item.fullname:=$property.value
					Else 
						$property.style:=Plain:K14:1
						$property.color:=lk inherited:K53:26
				End case 
				$item.properties.push($property)
				
			End if 
		End if 
	End if 
End for each 
$0:=$item