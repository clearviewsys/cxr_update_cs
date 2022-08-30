//%attributes = {}
// HTMLTableRow (data) -> htmlText

// return the code for a single HTML row

C_TEXT:C284($1; $0)

$0:="<tr>"+Char:C90(Carriage return:K15:38)
$0:=$0+$1+Char:C90(Carriage return:K15:38)
$0:=$0+"</tr>"