//%attributes = {}
// colourizeMandatoryField(tableNm,;fieldNum)

C_LONGINT:C283($1; $2; $tableNum; $fieldNum)
$tableNum:=$1
$fieldNum:=$2

C_TEXT:C284(theList)
C_BOOLEAN:C305(isMandatory; isEnterable; isModifiable)
GET FIELD ENTRY PROPERTIES:C685($tableNum; $fieldNum; theList; isMandatory; isEnterable; isModifiable)

If (isMandatory)
	colourizeField(Field:C253($tableNum; $fieldNum); True:C214)
End if 