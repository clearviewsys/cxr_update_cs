Class constructor($valuesParam : Collection; $formCodeParam : Integer)
	var $formCode : Integer
	Case of 
		: (Count parameters:C259=0)
			This:C1470.values:=New collection:C1472(\
				New object:C1471("key"; "First Name"; "value"; "Harry"; "style"; Bold:K14:2; "colour"; "red"); \
				New object:C1471("key"; "Last Name"; "value"; "Potter"; "style"; Bold:K14:2; "colour"; "red"); \
				New object:C1471("key"; "Address"; "value"; "123 First Harry Ave"; \
				"detail"; Formula:C1597(ALERT:C41($1+": "+$2)))\
				)
			$formCode:=Form event code:C388
		: (Count parameters:C259=1)
			This:C1470.values:=$valuesParam
			$formCode:=Form event code:C388
		: (Count parameters:C259=2)
			This:C1470.values:=$valuesParam
			$formCode:=$formCodeParam
		Else 
			assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
	End case 
	This:C1470.listBoxName:="lb_display"
	This:C1470.fieldColumn:="col_field"
	This:C1470.valueColumn:="col_value"
	This:C1470.dataColumn:="col_data"
	This:C1470.searchTerm:=""
	This:C1470.searchValues:=False:C215
	This:C1470.searchFields:=False:C215
	This:C1470.details:=New collection:C1472
	This:C1470._filterList()
	
Function setValues($valuesParam : Collection; $formCodeParam : Integer)
	var $formCode : Integer
	Case of 
		: (Count parameters:C259=0)
			This:C1470.values:=New collection:C1472
			$formCode:=Form event code:C388
		: (Count parameters:C259=1)
			This:C1470.values:=$valuesParam
			$formCode:=Form event code:C388
		: (Count parameters:C259=2)
			This:C1470.values:=$valuesParam
			$formCode:=$formCodeParam
		Else 
			assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
	End case 
	This:C1470._filterList()
	
Function handleListBox($formCodeParam : Integer)
	var $formCode : Integer
	Case of 
		: (Count parameters:C259=0)
			$formCode:=Form event code:C388
		: (Count parameters:C259=1)
			$formCode:=$formCodeParam
		Else 
			assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
	End case 
	
	Case of 
		: ($formCode=On Clicked:K2:4)
			var $column : Pointer
			$column:=OBJECT Get pointer:C1124(Object current:K67:2)
			var $index : Integer
			$index:=$column->
			If ($index<0)
				return 
			End if 
			
			var $data : Pointer
			var $detail : Object
			var $key; $value : Text
			var $data : Pointer
			$data:=OBJECT Get pointer:C1124(Object named:K67:5; This:C1470.dataColumn)
			$detail:=$data->{$index}
			If (OB Is defined:C1231($detail; "detail"))
				$key:=OBJECT Get pointer:C1124(Object named:K67:5; This:C1470.fieldColumn)->{$column->}
				$value:=OBJECT Get pointer:C1124(Object named:K67:5; This:C1470.valueColumn)->{$column->}
				
				$detail.detail.call($detail; $key; $value)
			End if 
	End case 
	
Function handleSearchTermInput($termParam : Text; $formCodeParam : Integer)
	var $formCode : Integer
	Case of 
		: (Count parameters:C259=0)
			This:C1470.searchTerm:=""
			$formCode:=Form event code:C388
		: (Count parameters:C259=1)
			This:C1470.searchTerm:=$termParam
			$formCode:=Form event code:C388
		: (Count parameters:C259=2)
			This:C1470.searchTerm:=$termParam
			$formCode:=$formCodeParam
		Else 
			assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
	End case 
	If ($formCode=On Data Change:K2:15)
		This:C1470._filterList()
	End if 
	
Function handleIsSearchValues($valueParam : Boolean; $formCodeParam : Integer)
	var $formCode : Integer
	Case of 
		: (Count parameters:C259=0)
			This:C1470.searchValues:=False:C215
			$formCode:=Form event code:C388
		: (Count parameters:C259=1)
			This:C1470.searchValues:=$valueParam
			$formCode:=Form event code:C388
		: (Count parameters:C259=2)
			This:C1470.searchValues:=$valueParam
			$formCode:=$formCodeParam
		Else 
			assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
	End case 
	If (Form event code:C388=On Clicked:K2:4)
		This:C1470._filterList()
	End if 
	
Function handleIsSearchFields($valueParam : Boolean; $formCodeParam : Integer)
	var $formCode : Integer
	Case of 
		: (Count parameters:C259=0)
			This:C1470.searchFields:=False:C215
			$formCode:=Form event code:C388
		: (Count parameters:C259=1)
			This:C1470.searchFields:=$valueParam
			$formCode:=Form event code:C388
		: (Count parameters:C259=2)
			This:C1470.searchFields:=$valueParam
			$formCode:=$formCodeParam
		Else 
			assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
	End case 
	If ($formCode=On Clicked:K2:4)
		This:C1470._filterList()
	End if 
	
Function _filterList()
	// MARK: Setup paramters
	var $listboxPtr : Pointer
	$listboxPtr:=OBJECT Get pointer:C1124(Object named:K67:5; This:C1470.listBoxName)
	Case of 
		: (Count parameters:C259=0)
		Else 
			assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
	End case 
	
	var $fields; $values; $data : Pointer
	$fields:=OBJECT Get pointer:C1124(Object named:K67:5; This:C1470.fieldColumn)
	$values:=OBJECT Get pointer:C1124(Object named:K67:5; This:C1470.valueColumn)
	$data:=OBJECT Get pointer:C1124(Object named:K67:5; This:C1470.dataColumn)
	This:C1470.details:=New collection:C1472
	ARRAY TEXT:C222($fields->; 0)
	ARRAY TEXT:C222($values->; 0)
	ARRAY OBJECT:C1221($data->; 0)
	ARRAY TEXT:C222($textColours; 0)
	ARRAY INTEGER:C220($textStyles; 0)
	
	var $filterOn; $searchValue; $searchField; $addLine : Boolean
	$filterOn:=This:C1470.searchTerm#""
	If (Not:C34(This:C1470.searchFields | This:C1470.searchValues))
		$searchValue:=True:C214
		$searchField:=True:C214
	Else 
		$searchValue:=This:C1470.searchValues
		$searchField:=This:C1470.searchFields
	End if 
	
	var $index : Integer
	$index:=1
	var $value : Object
	For each ($value; This:C1470.values)
		If ($filterOn)
			$addLine:=$searchValue ? $value.value=("@"+This:C1470.searchTerm+"@") : False:C215
			If (Not:C34($addLine))
				$addLine:=$searchField ? $value.key=("@"+This:C1470.searchTerm+"@") : False:C215
			End if 
		Else 
			$addLine:=True:C214
		End if 
		If (Not:C34($addLine))
			continue
		End if 
		APPEND TO ARRAY:C911($fields->; $value.key)
		APPEND TO ARRAY:C911($values->; $value.value)
		APPEND TO ARRAY:C911($textColours; (OB Is defined:C1231($value; "colour") ? $value.colour : ""))
		APPEND TO ARRAY:C911($textStyles; (OB Is defined:C1231($value; "style") ? $value.style : Plain:K14:1))
		APPEND TO ARRAY:C911($data->; $value)
	End for each 
	
	For ($index; 1; Size of array:C274($textColours))
		If ($textColours{$index}#"")
			LISTBOX SET ROW COLOR:C1270($listboxPtr->; $index; $textColours{$index})
		Else 
			LISTBOX SET ROW COLOR:C1270($listboxPtr->; $index; Foreground color:K23:1)
		End if 
		LISTBOX SET ROW FONT STYLE:C1268($listboxPtr->; $index; $textStyles{$index})
	End for 