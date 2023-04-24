//%attributes = {}
// AUS_CreateXMLElement

C_TEXT:C284($0; $newElement; $1; $parent; $2; $elemName; $3; $attr; $4; $value)
C_POINTER:C301($5; $ptrSeq)
C_BOOLEAN:C305($6; $increment)

ARRAY TEXT:C222($arrAttrNames; 0)
ARRAY TEXT:C222($arrAttrValues; 0)

Case of 
	: (Count parameters:C259=6)
		
		$parent:=$1
		$elemName:=$2
		$attr:=$3
		$value:=$4
		$ptrSeq:=$5
		$increment:=$6
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
C_TEXT:C284($0; $newElement)

AUS_ClearArrays(->$arrAttrNames; ->$arrAttrValues)
APPEND TO ARRAY:C911($arrAttrNames; $attr)
APPEND TO ARRAY:C911($arrAttrValues; $value+String:C10($ptrSeq->))

$newElement:=GAML_CreateXMLNode($parent; $elemName)
AUS_SetXmlAttrs($newElement; ->$arrAttrNames; ->$arrAttrValues)

If ($increment)
	$ptrSeq->:=$ptrSeq->+1
End if 


$0:=$newElement


