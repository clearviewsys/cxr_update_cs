//%attributes = {}

If ([AML_AggrRules:150]isActive:4)
	$0:=(100 << 16)+(200 << 8)+255  // Green
Else 
	$0:=(230 << 16)+(230 << 8)+230  // grey
End if 