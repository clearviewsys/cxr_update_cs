//%attributes = {}
C_OBJECT:C1216($1; $GetMethodInfoResult; $oneField)
C_TEXT:C284($2; $isRequired)
C_TEXT:C284($3; $isEnumarated)
C_TEXT:C284($4; $operator)
C_COLLECTION:C1488($0; $result)
C_BOOLEAN:C305($pushed)

$isRequired:=""
$isEnumarated:=""
$operator:="and"

$GetMethodInfoResult:=$1

If (Count parameters:C259>1)
	$isRequired:=$2
	If (Count parameters:C259>2)
		$isEnumarated:=$3
		If (Count parameters:C259>3)
			$operator:=$4
		End if 
	End if 
End if 

$result:=New collection:C1472

For each ($oneField; $GetMethodInfoResult.RequestFields.FieldInfo)
	
	Case of 
			
		: (($isRequired#"") & ($isEnumarated#"") & ($operator="and"))
			
			If (($oneField.IsRequired=$isRequired) & ($oneField.Enumerated=$isEnumarated))
				$result.push($oneField)
			End if 
			
		: (($isRequired#"") & ($isEnumarated#"") & ($operator="or"))
			
			If (($oneField.IsRequired=$isRequired) | ($oneField.Enumerated=$isEnumarated))
				$result.push($oneField)
			End if 
			
		: (($isRequired#"") & ($isEnumarated=""))
			
			If ($oneField.IsRequired=$isRequired)
				$result.push($oneField)
			End if 
			
		: (($isRequired="") & ($isEnumarated#""))
			
			If ($oneField.Enumerated=$isEnumarated)
				$result.push($oneField)
			End if 
			
			
	End case 
	
End for each 

$0:=$result
