//%attributes = {}
// Quotify ( aString ) -> text

// aString: text


// gets a string a return it in a double quotes



C_TEXT:C284($1; $0)

$0:=Char:C90(34)+$1+Char:C90(34)
