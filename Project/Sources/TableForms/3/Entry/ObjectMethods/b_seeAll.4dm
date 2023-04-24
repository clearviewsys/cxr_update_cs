
C_LONGINT:C283($win)
C_OBJECT:C1216($obj)

$obj:=New object:C1471

// #ORDA

// pass field pointer so we can know which table to query on

//$obj.recordIDFieldptr:=->[Customers]CustomerID
$obj.tableNo:=Table:C252(->[Customers:3])  // return the table no of the customers table
$obj.recordID:=[Customers:3]CustomerID:1

$win:=Open form window:C675([Addresses:147]; "ListboxForm")
DIALOG:C40([Addresses:147]; "ListboxForm"; $obj)  // the object is passed to the form.