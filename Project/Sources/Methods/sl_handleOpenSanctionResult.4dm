//%attributes = {}
utils_handleFormInArrListBox(Form:C1466.facets; "col_facets")
Form:C1466.tabs.index:=0
FORM GOTO PAGE:C247(1; *)
Form:C1466.data:=cs:C1710.HandleFieldValueListBox.new(New collection:C1472)
var $entityData : cs:C1710.HandleFieldValueListBox
$entityData:=cs:C1710.HandleFieldValueListBox.new(New collection:C1472)
$entityData.listBoxName:="lb_entityDisplay"
$entityData.fieldColumn:="col_field1"
$entityData.valueColumn:="col_value1"
$entityData.dataColumn:="col_data1"
Form:C1466.entityData:=$entityData
Form:C1466.display:=New object:C1471(\
"SearchTerm"; ""; \
"searchValues"; 0; \
"searchFields"; 0)
If (Not:C34(OB Is defined:C1231(Form:C1466; "entities")))
	Form:C1466.entities:=New collection:C1472
End if 
Form:C1466.saving:=New object:C1471("entities"; New collection:C1472; "matches"; New collection:C1472; \
"results"; New collection:C1472)