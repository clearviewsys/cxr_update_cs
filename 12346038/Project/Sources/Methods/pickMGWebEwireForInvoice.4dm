//%attributes = {}
C_COLLECTION:C1488($listboxcolumns)
C_OBJECT:C1216($0; $listboxcolumn; $parameters; $result)
C_TEXT:C284($1; $customerID; $qryString)
C_TEXT:C284($2; $transactionType)

$customerID:=$1
$transactionType:=""

If (Count parameters:C259>1)
	$transactionType:=$2
End if 

$listboxcolumns:=New collection:C1472

$listboxcolumn:=New object:C1471
$listboxcolumn.field:=->[WebEWires:149]WebEwireID:1
// $listboxcolumn.width:=60
$listboxcolumn.columntitle:="ID"
$listboxcolumn.columntitlestyle:=Bold:K14:2
$listboxcolumn.columntitlefont:="Arial"
$listboxcolumn.columntitlefontsize:=13
// $listboxcolumn.columnstyle:=Underline
//$listboxcolumn.columnfont:="Courier New"
$listboxcolumn.columnfontsize:=12
$listboxcolumns.push($listboxcolumn)


$listboxcolumn:=New object:C1471
$listboxcolumn.field:=->[WebEWires:149]paymentInfo:35
$listboxcolumn.objProperty:="result.destinationCountry"
// $listboxcolumn.width:=140
$listboxcolumn.columntitle:="Dest. country"
$listboxcolumn.columntitlestyle:=Bold:K14:2
$listboxcolumn.columntitlefont:="Arial"
$listboxcolumn.columntitlefontsize:=13
// no column settings
$listboxcolumns.push($listboxcolumn)


$listboxcolumn:=New object:C1471
$listboxcolumn.field:=->[WebEWires:149]toAmount:10
// make width 4D default, don't set it
// $listboxcolumn.width:=140
$listboxcolumn.columntitle:="To Amount"
$listboxcolumn.columntitlestyle:=Bold:K14:2
$listboxcolumn.columntitlefont:="Arial"
$listboxcolumn.columntitlefontsize:=13
// no column settings
$listboxcolumns.push($listboxcolumn)


$listboxcolumn:=New object:C1471
$listboxcolumn.field:=->[WebEWires:149]toCCY:11
// make width 4D default, don't set it
// $listboxcolumn.width:=140
$listboxcolumn.columntitle:="To CCY"
$listboxcolumn.columntitlestyle:=Bold:K14:2
$listboxcolumn.columntitlefont:="Arial"
$listboxcolumn.columntitlefontsize:=13
// no column settings
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=New object:C1471
$listboxcolumn.field:=->[WebEWires:149]fromAmount:3
// make width 4D default, don't set it
// $listboxcolumn.width:=140
$listboxcolumn.columntitle:="From Amount"
$listboxcolumn.columntitlestyle:=Bold:K14:2
$listboxcolumn.columntitlefont:="Arial"
$listboxcolumn.columntitlefontsize:=13
// no column settings
$listboxcolumns.push($listboxcolumn)


$listboxcolumn:=New object:C1471
$listboxcolumn.field:=->[WebEWires:149]fromCCY:5
// make width 4D default, don't set it
// $listboxcolumn.width:=140
$listboxcolumn.columntitle:="From CCY"
$listboxcolumn.columntitlestyle:=Bold:K14:2
$listboxcolumn.columntitlefont:="Arial"
$listboxcolumn.columntitlefontsize:=13
// no column settings
$listboxcolumns.push($listboxcolumn)


// to pass parameters use second parameter as object

$parameters:=New object:C1471

$qryString:="CustomerID = "+$customerID+" and isCancelled = false and WebEwireID = '@MG@' and paymentInfo.invoiceID = ''"

Case of 
		
	: ($transactionType="Send")
		
		$qryString:=$qryString+" and (paymentInfo.result.transactionStatus = 'AVAIL' "+\
			"or paymentInfo.result.transactionStatus='ReadyForPayout')"
		
		
	: ($transactionType="Receive")
		
		$qryString:=$qryString+" and paymentInfo.result.transactionStatus = 'RECVD'"
		
End case 

$parameters.preQueryStr:=$qryString
$parameters.makeSelection:=True:C214
$parameters.tableLabel:="MoneyGram transaction"
$parameters.searchtextlbl:="Search:"

$result:=pickRecords($listboxcolumns; $parameters)


If ($result#Null:C1517)
	$0:=$result.first()
End if 
