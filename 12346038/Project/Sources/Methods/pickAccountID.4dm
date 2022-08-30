//%attributes = {}
// PickAccountID(SearchString;->$returnPointer)
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
$listboxcolumn:=setListboxObjectProperties(->[Accounts:9]AccountID:1; 200; "Account ID")
$listboxcolumn.columnstyle:=Underline:K14:4
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=setListboxObjectProperties(->[Accounts:9]Currency:6; 50; "Currency")
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=setListboxObjectProperties(->[Accounts:9]CurrencyAlias:26; 50; "Currency Alias")
$listboxcolumns.push($listboxcolumn)

//$listboxcolumn:=setListboxObjectProperties (->[Invoices]CustomerFullName;180;"Customer Name")
//$listboxcolumns.push($listboxcolumn)

//$listboxcolumn:=setListboxObjectProperties (->[Invoices]invoiceDate;90;"Invoice Date")
//$listboxcolumns.push($listboxcolumn)

//$listboxcolumn:=setListboxObjectProperties (->[Invoices]fromAmount;90;"From Amount")
//$listboxcolumns.push($listboxcolumn)

//$listboxcolumn:=setListboxObjectProperties (->[Invoices]fromCurrency;60;"From Curr")
//$listboxcolumns.push($listboxcolumn)

//$listboxcolumn:=setListboxObjectProperties (->[Invoices]toAmount;90;"To Amount")
//$listboxcolumns.push($listboxcolumn)

//$listboxcolumn:=setListboxObjectProperties (->[Invoices]toCurrency;60;"To Curr")
//$listboxcolumns.push($listboxcolumn)

C_OBJECT:C1216($parameters)
$parameters:=New object:C1471
$parameters.tableLabel:="Accounts"
//$parameters.makeSelection := True;

$parameters.preQueryStr:="AccountID = "+$searchString+"@"


C_OBJECT:C1216($result)
$result:=pickRecords($listboxcolumns; $parameters)
If ($returnPointer#Null:C1517)
	$returnPointer->:=$result.AccountID[0]
End if 