//%attributes = {}
// PickInvoiceID(SearchString;->$returnPointer)
// #ORDA


C_TEXT:C284($1)
C_TEXT:C284($searchString)
C_POINTER:C301($returnPointer; $2)

If (Count parameters:C259>=1)
	$searchString:=$1
Else 
	$searchString:=""
End if 

If (Count parameters:C259>=2)
	$returnPointer:=$2
End if 

// new way using collection
C_COLLECTION:C1488($listboxcolumns)
C_OBJECT:C1216($listboxcolumn)

$listboxcolumns:=New collection:C1472

// all properties are present in first column
$listboxcolumn:=setListboxObjectProperties(->[Invoices:5]InvoiceID:1; 80; "Invoice ID")
$listboxcolumn.columnstyle:=Underline:K14:4
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=setListboxObjectProperties(->[Invoices:5]BranchID:53; 30; "Br")
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=setListboxObjectProperties(->[Invoices:5]CustomerID:2; 100; "Customer ID")
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=setListboxObjectProperties(->[Invoices:5]CustomerFullName:54; 180; "Customer Name")
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=setListboxObjectProperties(->[Invoices:5]invoiceDate:44; 90; "Invoice Date")
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=setListboxObjectProperties(->[Invoices:5]fromAmount:25; 90; "From Amount")
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=setListboxObjectProperties(->[Invoices:5]fromCurrency:3; 60; "From Curr")
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=setListboxObjectProperties(->[Invoices:5]toAmount:26; 90; "To Amount")
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=setListboxObjectProperties(->[Invoices:5]toCurrency:8; 60; "To Curr")
$listboxcolumns.push($listboxcolumn)

C_OBJECT:C1216($parameters)
$parameters:=New object:C1471
$parameters.tableLabel:="Invoice"
$parameters.preQueryStr:="CustomerID = "+$searchString+"@"


C_OBJECT:C1216($result)
$result:=pickRecords($listboxcolumns; $parameters)
If ($returnPointer#Null:C1517)
	$returnPointer->:=$result.InvoiceID[0]
End if 