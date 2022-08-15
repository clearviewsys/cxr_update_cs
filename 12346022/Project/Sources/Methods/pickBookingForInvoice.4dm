//%attributes = {}
// template_pickRecords

// how to use picker to pick multiple records

// this picker uses collection based listbox to display data 
// in $2 pass the collection of columns to be displayed in selection listbox
// in $1 you can pass ORDA query string to perform initial query on the table we choose records
// from, if that string is empty all the records will be available for selection

// #ORDA


C_COLLECTION:C1488($listboxcolumns)
C_OBJECT:C1216($listboxcolumn)
C_OBJECT:C1216($parameters)



$listboxcolumns:=New collection:C1472

// all properties we are supporting are present in this first column

$listboxcolumn:=New object:C1471
$listboxcolumn.field:=->[Bookings:50]BookingID:1
$listboxcolumn.width:=140
$listboxcolumn.columntitle:="Booking ID"
$listboxcolumn.columntitlestyle:=Bold:K14:2
$listboxcolumn.columntitlefont:="Arial"
$listboxcolumn.columntitlefontsize:=16
$listboxcolumn.columnfontsize:=12
$listboxcolumns.push($listboxcolumn)



$listboxcolumn:=New object:C1471
$listboxcolumn.field:=->[Bookings:50]BookingDate:3
// make width 4D default, don't set it
// $listboxcolumn.width:=140
$listboxcolumn.columntitle:="Date"
$listboxcolumn.columntitlestyle:=Bold:K14:2
$listboxcolumn.columntitlefont:="Arial"
$listboxcolumn.columntitlefontsize:=16
// no column settings
$listboxcolumn.columnfontsize:=12
$listboxcolumns.push($listboxcolumn)


$listboxcolumn:=New object:C1471
$listboxcolumn.field:=->[Bookings:50]Amount:9
// make width 4D default, don't set it
// $listboxcolumn.width:=140
$listboxcolumn.columntitle:="Amount"
$listboxcolumn.columntitlestyle:=Bold:K14:2
$listboxcolumn.columntitlefont:="Arial"
$listboxcolumn.columntitlefontsize:=16
// no column settings
$listboxcolumn.columnfontsize:=12
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=New object:C1471
$listboxcolumn.field:=->[Bookings:50]Currency:10
$listboxcolumn.columntitle:="CCY"
$listboxcolumn.columntitlestyle:=Bold:K14:2
$listboxcolumn.columntitlefont:="Arial"
$listboxcolumn.columntitlefontsize:=16
// no column settings
$listboxcolumn.columnfontsize:=12
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=New object:C1471
$listboxcolumn.field:=->[Bookings:50]isSell:7
$listboxcolumn.columntitle:="Sell"
$listboxcolumn.columntitlestyle:=Bold:K14:2
$listboxcolumn.columntitlefont:="Arial"
$listboxcolumn.columntitlefontsize:=16
// no column settings
$listboxcolumn.columnfontsize:=12
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=New object:C1471
$listboxcolumn.field:=->[Bookings:50]ourRate:11
$listboxcolumn.columntitle:="Rate"
$listboxcolumn.columntitlestyle:=Bold:K14:2
$listboxcolumn.columntitlefont:="Arial"
$listboxcolumn.columntitlefontsize:=16
// no column settings
$listboxcolumn.columnfontsize:=12
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=New object:C1471
$listboxcolumn.field:=->[Bookings:50]inverseRate:29
$listboxcolumn.columntitle:="Inv. Rate"
$listboxcolumn.columntitlestyle:=Bold:K14:2
$listboxcolumn.columntitlefont:="Arial"
$listboxcolumn.columntitlefontsize:=16
// no column settings
$listboxcolumn.columnfontsize:=12
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=New object:C1471
$listboxcolumn.field:=->[Bookings:50]ReferenceNo:31
$listboxcolumn.columntitle:="Reference"
$listboxcolumn.columntitlestyle:=Bold:K14:2
$listboxcolumn.columntitlefont:="Arial"
$listboxcolumn.columntitlefontsize:=16
// no column settings
$listboxcolumn.columnfontsize:=12
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=New object:C1471
$listboxcolumn.field:=->[Bookings:50]autoComments:24
$listboxcolumn.columntitle:="Comments"
$listboxcolumn.columntitlestyle:=Bold:K14:2
$listboxcolumn.columntitlefont:="Arial"
$listboxcolumn.columntitlefontsize:=16
// no column settings
$listboxcolumn.columnfontsize:=12
$listboxcolumns.push($listboxcolumn)

// to pass parameters use second parameter as object

$parameters:=New object:C1471
$parameters.makeSelection:=False:C215

$parameters.preQueryStr:="(CustomerID =="+vCustomerID+\
" AND isConfirmed == True AND isHonored == False)"
$parameters.tableLabel:="Open Booking Request "


//add an OR webewireid = [webewires]webewireid
// you can call method with listbox columns only




C_OBJECT:C1216($result)
$result:=pickRecords($listboxcolumns; $parameters)

If ($result#Null:C1517)
	$0:=$result.first().BookingID
End if 


