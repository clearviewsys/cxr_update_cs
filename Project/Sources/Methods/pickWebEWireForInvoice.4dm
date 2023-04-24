//%attributes = {}
// template_pickRecords

// how to use picker to pick multiple records

// this picker uses collection based listbox to display data 
// in $2 pass the collection of columns to be displayed in selection listbox
// in $1 you can pass ORDA query string to perform initial query on the table we choose records
// from, if that string is empty all the records will be available for selection

// #ORDA

C_TEXT:C284($1; $type)

C_COLLECTION:C1488($listboxcolumns)
C_OBJECT:C1216($listboxcolumn)
C_OBJECT:C1216($parameters)



If (Count parameters:C259>=1)
	$type:=$1
Else 
	$type:="ewire"
End if 

$listboxcolumns:=New collection:C1472

// all properties we are supporting are present in this first column

$listboxcolumn:=New object:C1471
$listboxcolumn.field:=->[WebEWires:149]creationDate:15
$listboxcolumn.width:=140
$listboxcolumn.columntitle:="Creation Date"
$listboxcolumn.columntitlestyle:=Bold:K14:2
$listboxcolumn.columntitlefont:="Arial"
$listboxcolumn.columntitlefontsize:=16
$listboxcolumn.columnfontsize:=12
$listboxcolumns.push($listboxcolumn)



$listboxcolumn:=New object:C1471
$listboxcolumn.field:=->[WebEWires:149]toParty:8
$listboxcolumn.objProperty:="fullName"
// make width 4D default, don't set it
// $listboxcolumn.width:=140
$listboxcolumn.columntitle:="Beneficiary Name"
$listboxcolumn.columntitlestyle:=Bold:K14:2+Italic:K14:3
$listboxcolumn.columntitlefont:="Arial"
$listboxcolumn.columntitlefontsize:=16
// no column settings
$listboxcolumn.columnfontsize:=12
$listboxcolumns.push($listboxcolumn)



$listboxcolumn:=New object:C1471
$listboxcolumn.field:=->[WebEWires:149]toAmount:10
// make width 4D default, don't set it
// $listboxcolumn.width:=140
$listboxcolumn.columntitle:="Amount"
$listboxcolumn.columntitlestyle:=Bold:K14:2+Italic:K14:3
$listboxcolumn.columntitlefont:="Arial"
$listboxcolumn.columntitlefontsize:=16
// no column settings
$listboxcolumn.columnfontsize:=12
$listboxcolumns.push($listboxcolumn)


$listboxcolumn:=New object:C1471
$listboxcolumn.field:=->[WebEWires:149]toCCY:11
// make width 4D default, don't set it
// $listboxcolumn.width:=140
$listboxcolumn.columntitle:="Currency"
$listboxcolumn.columntitlestyle:=Bold:K14:2+Italic:K14:3
$listboxcolumn.columntitlefont:="Arial"
$listboxcolumn.columntitlefontsize:=16
// no column settings
$listboxcolumn.columnfontsize:=12
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=New object:C1471
$listboxcolumn.field:=->[WebEWires:149]status:16
$listboxcolumn.columntitle:="Status"
$listboxcolumn.columntitlestyle:=Bold:K14:2+Italic:K14:3
$listboxcolumn.columntitlefont:="Arial"
$listboxcolumn.columntitlefontsize:=16
// no column settings
$listboxcolumn.columnfontsize:=12
$listboxcolumns.push($listboxcolumn)




// to pass parameters use second parameter as object

$parameters:=New object:C1471
$parameters.makeSelection:=False:C215

Case of 
	: ($type="MG")
		$parameters.preQueryStr:="(status = 20 & CustomerID ="+[Customers:3]CustomerID:1+\
			" & WebEwireID == '@MGS@')"
		$parameters.tableLabel:="MoneyGram Request "
	: ($type="wire")
		$parameters.preQueryStr:="(status = 20 & CustomerID ="+[Customers:3]CustomerID:1+\
			" & WebEwireID == '@WIR@') OR WebEwireID = "+[Wires:8]WireNo:48  // need to look at how a [wire] will link to [webewires]???
		$parameters.tableLabel:="Wire Request "
	Else   // fallback ewire
		If ([eWires:13]WebEwireID:123="")
			$parameters.preQueryStr:="status = 20 & CustomerID ="+[Customers:3]CustomerID:1+" & WebEwireID # '@MGS@'"+\
				" & WebEwireID # '@WIR@'"
		Else 
			$parameters.preQueryStr:="(status = 20 & CustomerID ="+[Customers:3]CustomerID:1+" & WebEwireID # '@MGS@'"+\
				" & WebEwireID # '@WIR@') OR WebEwireID = "+[eWires:13]WebEwireID:123
		End if 
		$parameters.tableLabel:="eWire Request "
End case 

//add an OR webewireid = [webewires]webewireid
// you can call method with listbox columns only




C_OBJECT:C1216($result)
$result:=pickRecords($listboxcolumns; $parameters)

If ($result#Null:C1517)
	$0:=$result.first().WebEwireID
End if 


