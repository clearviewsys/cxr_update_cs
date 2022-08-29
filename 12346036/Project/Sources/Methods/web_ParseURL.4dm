//%attributes = {}
// ParseURL (URL:string; »var1:string; »var2:string)
// this method sets the value of var1 and var2
// just by sending it the URL in this format
// URL format: .../string1/string2


C_TEXT:C284($1; $URLTail)
C_LONGINT:C283($SlashPosition)
C_POINTER:C301($2; $3)

$URLTail:=Substring:C12($1; 2)
$SlashPosition:=Position:C15("/"; $URLTail)

$2->:=Substring:C12($URLTail; 1; $slashposition-1)
$3->:=Substring:C12($URLTail; $SlashPosition+1)