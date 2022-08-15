//%attributes = {}
C_POINTER:C301($tablePtr)
C_TEXT:C284($text; $0)
C_LONGINT:C283($i)

$text:=""
ARRAY POINTER:C280($arrTables; 4)
$arrTables{1}:=->[Registers:10]
$arrTables{2}:=->[Invoices:5]
$arrTables{3}:=->[Customers:3]
$arrTables{4}:=->[eWires:13]

For ($i; 1; Size of array:C274($arrTables))
	$tablePtr:=$arrTables{$i}
	$text:=$text+Table name:C256($tablePtr)+" : "+Char:C90(Tab:K15:37)+String:C10(Records in table:C83($tablePtr->); "|NumberNoZero")+CRLF
End for 
$0:=$text
