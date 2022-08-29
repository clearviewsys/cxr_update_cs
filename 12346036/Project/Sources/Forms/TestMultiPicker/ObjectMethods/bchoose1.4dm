If (False:C215)
	pickMultipleRecordsOLD(""; ->[Invoices:5]InvoiceID:1; ->[Invoices:5]invoiceDate:44)
Else 
	
	// new way using collection
	C_COLLECTION:C1488($listboxcolumns)
	C_OBJECT:C1216($listboxcolumn)
	
	$listboxcolumns:=New collection:C1472
	
	// all properties are present in first column
	
	$listboxcolumn:=New object:C1471
	$listboxcolumn.field:=->[Invoices:5]InvoiceID:1
	$listboxcolumn.width:=80
	$listboxcolumn.columntitle:="Invoice ID"
	$listboxcolumn.columntitlestyle:=Bold:K14:2
	$listboxcolumn.columntitlefont:="Arial"
	$listboxcolumn.columntitlefontsize:=14
	$listboxcolumn.columnstyle:=Underline:K14:4
	$listboxcolumn.columnfont:="Courier New"
	$listboxcolumn.columnfontsize:=11
	$listboxcolumns.push($listboxcolumn)
	
	$listboxcolumn:=New object:C1471
	$listboxcolumn.field:=->[Invoices:5]invoiceDate:44
	// make width 4D default
	// $listboxcolumn.width:=140
	$listboxcolumn.columntitle:="Invoice Date"
	$listboxcolumn.columntitlestyle:=Bold:K14:2+Italic:K14:3
	$listboxcolumn.columntitlefont:="Arial"
	$listboxcolumn.columntitlefontsize:=16
	// no column settings
	$listboxcolumns.push($listboxcolumn)
	
	pickRecords($listboxcolumns)
	
End if 
