//%attributes = {}
//setTitleIff (booleanCondition; objectName;title)
// Set title if and only if the condition is true

C_BOOLEAN:C305($1; $condition)
C_TEXT:C284($2; $3; $widgetName; $title)

Case of 
	: (Count parameters:C259=3)
		$condition:=$1
		$widgetName:=$2
		$title:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($condition)
	OBJECT SET TITLE:C194(*; $widgetName; $title)
Else 
	OBJECT SET TITLE:C194(*; $widgetName; "")
End if 