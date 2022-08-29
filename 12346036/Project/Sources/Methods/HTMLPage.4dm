//%attributes = {}
// HTMLPage(title;body) -> HTMLtext

// generate the code for a simple HTML page with head , title and body


C_TEXT:C284($1; $2; $0)

$0:="<html>"+Char:C90(13)+"<head>"+Char:C90(13)+"<title>"+$1+"</title></head>"+Char:C90(Carriage return:K15:38)
$0:=$0+"<body>"+$2+"</body></html>"