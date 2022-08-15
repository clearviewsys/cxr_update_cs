//%attributes = {}
// enTag(tag;Value) -> string
// enclose in XML (or HTML) tags
// eg: enTag("Body";"Hello World") 

C_TEXT:C284($1; $2; $0)

$0:="<"+$1+">"+$2+"</"+$1+">"+CRLF