//%attributes = {}
// The collection in parameter $1 must have following properties

// $1.field:=->[Customers]LastName is field pointer to a field to be displayed in listbox column

// The collection in parameter $2 may have following properties

//$listboxcolumn.width:=140
//$listboxcolumn.columntitle:="Last name"
//$listboxcolumn.columntitlestyle:=Bold
//$listboxcolumn.columntitlefont:="Arial"
//$listboxcolumn.columntitlefontsize:=16
//$listboxcolumn.columnstyle:=Underline
//$listboxcolumn.columnfont:="Courier New"
//$listboxcolumn.columnfontsize:=12

// #ORDA
C_TEXT:C284($preQueryString)  // Make this selection first, then query within i.e. filter hidden Accounts
C_COLLECTION:C1488($1; $ListBoxColumns)
C_OBJECT:C1216($2; $parameters)  // display this instead of table name
C_OBJECT:C1216($0)  // return entity selection
C_LONGINT:C283($i; $winref)
C_OBJECT:C1216($Form_obj)
C_POINTER:C301($tablePtr)
C_BOOLEAN:C305($make4DSelection)
C_TEXT:C284($tableLabel)

$make4DSelection:=True:C214  // make selection in a table by default

If (Count parameters:C259<1)
	
	assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
	
Else 
	
	$Form_obj:=New object:C1471
	$ListBoxColumns:=$1
	$tableLabel:=""
	
	If (Count parameters:C259>1)
		$parameters:=$2
	End if 
	
	ASSERT:C1129(($ListBoxColumns.length>0); "Collection of listbox columns is empty")
	ASSERT:C1129(($ListBoxColumns[0].field#Null:C1517); "Collection missing required property field in first element")
	
	$TablePtr:=Table:C252(Table:C252($ListBoxColumns[0].field))
	$Form_obj.whichDataStore:=Table name:C256($TablePtr)
	$Form_obj.listbox_columns:=$ListBoxColumns
	
	If ($parameters#Null:C1517)
		If ($parameters.makeSelection#Null:C1517)
			$make4DSelection:=$parameters.makeSelection
		End if 
		If ($parameters.tableLabel#Null:C1517)
			$Form_obj.tableLabel:=$parameters.tableLabel
		End if 
		If ($parameters.initialUserSearchString#Null:C1517)
			If ($parameters.initialUserSearchString#"")
				$Form_obj.initialUserSearchString:=$parameters.initialUserSearchString
			End if 
		End if 
		If ($parameters.preQueryStr#Null:C1517)
			$Form_obj.preQueryStr:=$parameters.preQueryStr
		Else 
			$Form_obj.preQueryStr:=""
		End if 
		If ($parameters.listboxBottom#Null:C1517)
			$Form_obj.listboxBottom:=$parameters.listboxBottom
		End if 
		If ($parameters.searchtextlbl#Null:C1517)
			$Form_obj.searchtextlbl:=$parameters.searchtextlbl
		End if 
	End if 
	
	$winref:=Open form window:C675("Picker_Multi")
	DIALOG:C40("Picker_Multi"; $Form_obj)
	CLOSE WINDOW:C154($winref)
	
	If (OK=1)
		
		$0:=$Form_obj.selectedItems
		
		If ($Form_obj.selectedItems#Null:C1517)
			If ($make4DSelection)
				USE ENTITY SELECTION:C1513($Form_obj.selectedItems)
			End if 
		End if 
	Else 
		//C_OBJECT($currEWire)
		//$currEWire:=ds.WebEWires.query("WebEwireID="+[eWires]WebEwireID).first()
		//If ($currEWire#Null)
		//$currEWire.status:=30
		//$currEWire.save()
		//End if 
	End if 
	
End if 
