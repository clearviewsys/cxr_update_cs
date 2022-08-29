//%attributes = {}
// PickCustomerID(SearchString;->returnPointer)
// #ORDA


C_TEXT:C284($searchString)
C_POINTER:C301($returnPointer)

If (Count parameters:C259>=1)
	C_TEXT:C284($1)
	$searchString:=$1
Else 
	$searchString:=""
End if 

If (Count parameters:C259>=2)
	C_POINTER:C301($2)
	$returnPointer:=$2
End if 
// new way using collection
C_COLLECTION:C1488($listboxcolumns)
C_OBJECT:C1216($listboxcolumn)

$listboxcolumns:=New collection:C1472

// all properties are present in first column
$listboxcolumn:=setListboxObjectProperties(->[Customers:3]CustomerID:1; 80; "Customer ID")
$listboxcolumn.columnstyle:=Underline:K14:4
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=setListboxObjectProperties(->[Customers:3]ExternalAccountNo:96; 80; "Account No")
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=setListboxObjectProperties(->[Customers:3]FirstName:3; 110; "First Name")
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=setListboxObjectProperties(->[Customers:3]LastName:4; 110; "Last Name")
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=setListboxObjectProperties(->[Customers:3]CompanyName:42; 100; "Company Name")
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=setListboxObjectProperties(->[Customers:3]Email:17; 110; "Email")
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=setListboxObjectProperties(->[Customers:3]Address:7; 200; "Address")
$listboxcolumns.push($listboxcolumn)


C_OBJECT:C1216($parameters)
$parameters:=New object:C1471
$parameters.tableLabel:="Customer"
$parameters.initialUserSearchString:=$searchString
// $parameters.preQueryStr:="LastName = "+$searchString+"@"

// do not make selection in table, we will use just the entity selection
//$parameters.makeSelection:=False

C_OBJECT:C1216($result)
$result:=pickRecords($listboxcolumns; $parameters)
If ($returnPointer#Null:C1517)
	$returnPointer->:=$result.CustomerID[0]
	
	Case of 
		: ($returnPointer=(->[Relations:154]customerID:3))
			C_POINTER:C301($ptr)
			$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "customerFullName")
			$ptr->:=$result.FullName[0]
		: ($returnPointer=(->[Relations:154]toCustomerID:4))
			C_POINTER:C301($ptr)
			$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "toCustomerFullName")
			$ptr->:=$result.FullName[0]
	End case 
End if 