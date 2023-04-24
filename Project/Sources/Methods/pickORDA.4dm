//%attributes = {}
// pickORDA (->widget; ->fieldPtr;onSelection; initialSearchString)
// a General Picker with ORDA and Classic 4D mix. keeps compatibility with previous pickTable method
// #ORDA

C_LONGINT:C283($win)
C_OBJECT:C1216($obj)
C_POINTER:C301($tablePtr; $fieldPtr; $widgetPtr; $1; $2)
C_BOOLEAN:C305($onSelection; $3)
C_TEXT:C284($searchString; $4)

C_TEXT:C284($customerID)

Case of 
	: (Count parameters:C259=0)
		$widgetPtr:=->$customerID
		$fieldPtr:=->[Customers:3]CustomerID:1
		$onSelection:=False:C215
		$searchString:=$widgetPtr->
		
	: (Count parameters:C259=1)
		$widgetPtr:=$1
		$fieldPtr:=->[Customers:3]CustomerID:1
		$onSelection:=False:C215
		$searchString:=$widgetPtr->
		
	: (Count parameters:C259=2)
		$widgetPtr:=$1
		$fieldPtr:=$2
		$onSelection:=False:C215
		$searchString:=$widgetPtr->  // the value of the field is what the initial value should be
		
	: (Count parameters:C259=3)
		$widgetPtr:=$1
		$fieldPtr:=$2
		$onSelection:=$3
		$searchString:=$widgetPtr->
		
	: (Count parameters:C259=4)
		$widgetPtr:=$1
		$fieldPtr:=$2
		$onSelection:=$3
		$searchString:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$tablePtr:=Table:C252(Table:C252($fieldPtr))  // the pointer to the same table as the field is pointing to

$obj:=New object:C1471
$obj.searchString:=$searchString
$obj.title:=getElegantTableName($tablePtr)+" Picker"
$obj.searchMethod:="search"+Table name:C256($tablePtr)  // e.g. searchCustomers
//searchCustomers 
If ($onSelection=False:C215)
	READ ONLY:C145($tablePtr->)
	ALL RECORDS:C47($tablePtr->)
End if 

$obj.pickerList:=Create entity selection:C1512($tablePtr->)
//$obj.pickerList:=ds.Customers.all()  // or any other query goes here

$obj.initialList:=Create entity selection:C1512($tablePtr->)  // keep a version of the original selection
//$obj.totalSample:=$obj.Cust.length()// total count

$win:=Open form window:C675($tablePtr->; "Picker")
//[Customers];"Picker"

DIALOG:C40($tablePtr->; "Picker"; $obj)  // $obj is passed to the Form object of that form. 

If (OK=1)
	If ($obj.selectedEntities#Null:C1517)
		READ ONLY:C145($tablePtr->)
		USE ENTITY SELECTION:C1513($obj.selectedEntities)
		GOTO SELECTED RECORD:C245($tablePtr->; 1)
		$widgetPtr->:=$fieldPtr->
	End if 
	//displaySelectedRecords ($tablePtr)
End if 