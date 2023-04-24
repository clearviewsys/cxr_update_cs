//%attributes = {}


If ([SanctionLists:113]IsEnabled:4 && ([SanctionLists:113]automaticFlags:11=0))
	var $flags : Collection
	$flags:=New collection:C1472("Customer"; "Invoice"; "Link"; "eWire"; \
		"Agent"; "ThirdParty"; "Wire")
	var $index : Integer
	$index:=0
	var $flag : Text
	For each ($flag; $flags)
		sl_setScreeningForTable($index)
		$index:=$index+1
	End for each 
End if 