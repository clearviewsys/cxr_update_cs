//%attributes = {}
// handleSizeOfImageVar (->sizeOfImageVar; ->imageField; varObjectName)
// e.g. handleSizeOfImageVar (self, ->[customers]picture;"vSizeOfImage")

C_POINTER:C301($objPtr; $imagePtr; $1; $2)
C_TEXT:C284($objectName; $3)

$objPtr:=$1
$imagePtr:=$2
$objectName:=$3


C_TEXT:C284(vSizeOfImage)
C_LONGINT:C283($sizeInKB)
$sizeInKB:=Picture size:C356($imagePtr->)/1000

$objPtr->:=String:C10($sizeInKB; "###,###,###,###.#")+" KB"

If ($sizeInKB>100)
	colourizeObject($objectName; Red:K11:4; Light grey:K11:13)
Else 
	colourizeObject($objectName; Black:K11:16; Light grey:K11:13)
End if 