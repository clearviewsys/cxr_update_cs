//%attributes = {}

// PickCompanyCustomer(SearchString;->returnPointer;->returnPointerName)
// #ORDA


C_TEXT:C284($searchString)
C_POINTER:C301($returnPointer; $returnPointerName)

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
If (Count parameters:C259>=3)
	C_POINTER:C301($3)
	$returnPointerName:=$3
End if 
// new way using collection
C_COLLECTION:C1488($listboxcolumns)
C_OBJECT:C1216($listboxcolumn)

$listboxcolumns:=New collection:C1472

// all properties are present in first column
$listboxcolumn:=setListboxObjectProperties(->[Customers:3]CustomerID:1; 80; "Company ID")
$listboxcolumn.columnstyle:=Underline:K14:4
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=setListboxObjectProperties(->[Customers:3]CompanyName:42; 200; "Company Name")
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=setListboxObjectProperties(->[Customers:3]Address:7; 200; "Address")
$listboxcolumns.push($listboxcolumn)


C_OBJECT:C1216($parameters)
$parameters:=New object:C1471
$parameters.tableLabel:="Company"
$parameters.initialUserSearchString:=$searchString
$parameters.preQueryStr:="isCompany = True"
$parameters.makeSelection:=False:C215
$parameters.listboxBottom:=200

C_OBJECT:C1216($result)
$result:=pickRecords($listboxcolumns; $parameters)
If ($returnPointer#Null:C1517) & ($result#Null:C1517)
	If ($result.CustomerID[0]#"")
		$returnPointer->:=$result.CustomerID[0]
		$returnPointerName->:=$result.FullName[0]
		If (Old:C35([Customers:3]CompanyID:141)#[Customers:3]CompanyID:141)
			sl_handleCustomerScreening(sl_CustomerCompany+sl_ForAutoCall)
			//sl_handleCompanyNameCompliance(True)
		End if 
	End if 
End if 