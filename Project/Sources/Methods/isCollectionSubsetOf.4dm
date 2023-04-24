//%attributes = {}
// checks if collection $col1 is contained in another collection $col2

#DECLARE($col1 : Collection; $col2 : Collection)->$isSubset : Boolean

var $colTmp : Collection
var $i : Integer

$isSubset:=False:C215

If ($col1.length<=$col2.length)
	
	$colTmp:=getAllColCombinations($col2; $col1.length)
	
	
	For ($i; 1; $colTmp.length)
		
		If ($col1.equal($colTmp[$i-1]))
			$isSubset:=True:C214
			break
		End if 
		
	End for 
	
Else 
	// bigger than collection that should contain it. $isSubset already false here.
End if 

