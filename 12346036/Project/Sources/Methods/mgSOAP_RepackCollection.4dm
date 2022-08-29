//%attributes = {}
// builds collection of objects from MoneyGram SOAP API call result

C_COLLECTION:C1488($0; $1; $inCollection; $outCollection)
C_OBJECT:C1216($inField; $outField; $inProperty)
C_LONGINT:C283($type)

$inCollection:=$1

If ($inCollection#Null:C1517)
	
	$outCollection:=New collection:C1472
	
	For each ($inField; $inCollection)
		
		$outField:=New object:C1471
		$type:=Value type:C1509($inField.Field)
		
		If ($type=Is collection:K8:32)
			For each ($inProperty; $inField.Field)
				$outField[$inProperty.Name]:=$inProperty.Value
			End for each 
		Else 
			If ($type=Is object:K8:27)
				$outField[$inField.Field.Name]:=$inField.Field.Value
			End if 
		End if 
		
		$outCollection.push($outField)
		
	End for each 
	
End if 

$0:=$outCollection
