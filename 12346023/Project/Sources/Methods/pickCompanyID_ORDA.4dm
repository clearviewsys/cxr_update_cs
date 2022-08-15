//%attributes = {}
// pickCompanyID_ORDA (->widget; ->CompanyName)
// a General Picker with ORDA - TB
// #ORDA

C_LONGINT:C283($win)
C_OBJECT:C1216($obj)
C_POINTER:C301($tablePtr; $fieldPtr; $widgetPtr; $companyNamePtr; $1; $2)
C_BOOLEAN:C305($onSelection; $3)
C_TEXT:C284($searchString; $4)
C_TEXT:C284($companyID; $companyName; $0)

C_TEXT:C284($customerID)

Case of 
	: (Count parameters:C259=0)
		$widgetPtr:=->$customerID
		$onSelection:=False:C215
		$searchString:=$widgetPtr->
		
	: (Count parameters:C259=1)
		$widgetPtr:=$1
		$searchString:=$widgetPtr->
	: (Count parameters:C259=2)
		$widgetPtr:=$1
		$companyNamePtr:=$2
		$searchString:=$widgetPtr->
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$tablePtr:=->[Customers:3]  // the pointer to the same table as the field is pointing to

$obj:=New object:C1471
$obj.searchString:=$searchString
$obj.title:=getElegantTableName($tablePtr)+" Picker"

$obj.pickerList:=ds:C1482.Customers.query("isCompany = true").orderBy("FullName")  // or any other query goes here
$obj.initialList:=ds:C1482.Customers.query("isCompany = true")  // keep a version of the original selection

$win:=Open form window:C675($tablePtr->; "Pick_ORDA")


DIALOG:C40($tablePtr->; "Pick_ORDA"; $obj)  // $obj is passed to the Form object of that form. 

If (OK=1)
	If ($obj.selectedEntities#Null:C1517)
		$companyID:=$obj.selectedEntities[0].CustomerID  // first element of the result
		$companyName:=$obj.selectedEntities[0].CompanyName
		$widgetPtr->:=$companyID
		$companyNamePtr->:=$companyName
		$0:=$companyName
	End if 
	//displaySelectedRecords ($tablePtr)
End if 