//%attributes = {}
var $flags : Collection
$flags:=New collection:C1472("Customer"; "Invoice"; "Link"; "eWire"; \
"Agent"; "ThirdParty"; "Wire")
var $screenTable : Integer
$screenTable:=0
var $flag : Text
For each ($flag; $flags)
	var $checkBox : Pointer
	$checkBox:=OBJECT Get pointer:C1124(Object named:K67:5; "but_screen"+$flag)
	OBJECT SET ENABLED:C1123($checkBox->; [SanctionLists:113]IsEnabled:4)
	$checkBox->:=sl_isScreeningForTable($screenTable)
	$screenTable:=$screenTable+1
End for each 

OBJECT SET ENABLED:C1123(*; "but_manual"; [SanctionLists:113]IsEnabled:4)