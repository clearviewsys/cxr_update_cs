//%attributes = {}
C_OBJECT:C1216($0; $obj; $oneEnum)
C_COLLECTION:C1488($1; $states)  // copy enumerated values from this collection
C_TEXT:C284($2; $name)
C_TEXT:C284($3; $caption)
C_TEXT:C284($4; $enumLabelProperty)
C_TEXT:C284($5; $enumValueProperty)
C_TEXT:C284($6; $defaultValue)

$states:=$1
$name:=$2
$caption:=$3
$enumLabelProperty:=$4
$enumValueProperty:=$5

If (Count parameters:C259>5)
	$defaultValue:=$6
Else 
	$defaultValue:=""
End if 

$obj:=New object:C1471
//$obj.Name:="SenderState"
$obj.Name:=$name
//$obj.Caption:="Sender state"
$obj.Caption:=$caption
$obj.Enumerated:="true"
$obj.EnumeratedValues:=New object:C1471
$obj.EnumeratedValues.EnumeratedValuesInfo:=New collection:C1472
If ($defaultValue#"")
	$obj.defaultValue:=$defaultValue
End if 

For each ($oneEnum; $states)
	$obj.EnumeratedValues.EnumeratedValuesInfo.push(\
		New object:C1471("EnumeratedValue"; $oneEnum[$enumValueProperty]; \
		"EnumeratedLabel"; $oneEnum[$enumLabelProperty]))
End for each 

$0:=$obj
