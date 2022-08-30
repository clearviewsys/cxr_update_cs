//%attributes = {}
// HTMLHiddenField (Name;Value) -> HTMLtext

C_TEXT:C284($1; $2; $0)

$0:="<input name="+Quotify($1)+"  type="+Quotify("Hidden")+" value="+Quotify($2)+">"

