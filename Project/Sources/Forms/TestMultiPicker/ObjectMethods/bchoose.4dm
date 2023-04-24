// #ORDA

If (Shift down:C543)
	// old way
	// pickMultipleRecords("";->[Customers]LastName;->[Customers]FirstName;->[Customers]City)
Else 
	// new way using collection
	C_COLLECTION:C1488($listboxcolumns)
	C_OBJECT:C1216($listboxcolumn)
	
	$listboxcolumns:=New collection:C1472
	
	// all properties are present in first column
	
	$listboxcolumn:=New object:C1471
	$listboxcolumn.field:=->[Customers:3]LastName:4
	$listboxcolumn.width:=140
	$listboxcolumn.columntitle:="Last name"
	$listboxcolumn.columntitlestyle:=Bold:K14:2
	$listboxcolumn.columntitlefont:="Arial"
	$listboxcolumn.columntitlefontsize:=16
	$listboxcolumn.columnstyle:=Underline:K14:4
	$listboxcolumn.columnfont:="Courier New"
	$listboxcolumn.columnfontsize:=12
	$listboxcolumns.push($listboxcolumn)
	
	$listboxcolumn:=New object:C1471
	$listboxcolumn.field:=->[Customers:3]FirstName:3
	// make width 4D default
	// $listboxcolumn.width:=140
	$listboxcolumn.columntitle:="First name"
	$listboxcolumn.columntitlestyle:=Bold:K14:2+Italic:K14:3
	$listboxcolumn.columntitlefont:="Arial"
	$listboxcolumn.columntitlefontsize:=16
	// no column settings
	$listboxcolumns.push($listboxcolumn)
	
	
	$listboxcolumn:=New object:C1471
	$listboxcolumn.field:=->[Customers:3]City:8
	$listboxcolumn.width:=100
	$listboxcolumns.push($listboxcolumn)
	pickRecords($listboxcolumns)
	
End if 
