//%attributes = {}
// HTMLTableRow (data) -> htmlText

// return the code for a single HTML row

C_TEXT:C284($1; $0)

$0:="<td>"+$1+"</td>"+Char:C90(13)