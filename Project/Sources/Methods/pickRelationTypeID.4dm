//%attributes = {}
//pickRelationTypeID(SearchString;->returnPointer)
// #ORDA

C_TEXT:C284($searchString)

If (Count parameters:C259>=1)
	C_TEXT:C284($1)
	$searchString:=$1
Else 
	$searchString:=""
End if 

If (Count parameters:C259>=2)
	C_POINTER:C301($2; $returnPointer)
	$returnPointer:=$2
End if 
// new way using collection
C_COLLECTION:C1488($listboxcolumns)
C_OBJECT:C1216($listboxcolumn)

$listboxcolumns:=New collection:C1472

// all properties are present in first column
$listboxcolumn:=setListboxObjectProperties(->[RelationTypes:156]relationTypeID:1; 80; "Relation Type ID")
$listboxcolumn.columnstyle:=Underline:K14:4
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=setListboxObjectProperties(->[RelationTypes:156]Description:2; 150; "Description")
$listboxcolumns.push($listboxcolumn)



C_OBJECT:C1216($parameters)
$parameters:=New object:C1471
$parameters.tableLabel:="Relation Types"
$parameters.initialUserSearchString:=$searchString
// $parameters.preQueryStr:="LastName = "+$searchString+"@"

// do not make selection in table, we will use just the entity selection
//$parameters.makeSelection:=False

C_OBJECT:C1216($result)
$result:=pickRecords($listboxcolumns; $parameters)
If ($returnPointer#Null:C1517)
	$returnPointer->:=$result.relationTypeID[0]
	C_POINTER:C301($ptr)
	$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "relationType")
	$ptr->:=$result.Description[0]
	
End if 