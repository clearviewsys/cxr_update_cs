//%attributes = {}
// getYahooUpdateDate (->HTML)-> DateText


C_POINTER:C301($1)
C_TEXT:C284($0; $startTag; $endTag)
C_LONGINT:C283($start; $end)
$startTag:="valign=middle>"
$endTag:="</font>"
$start:=Position:C15($startTag; $1->)+Length:C16($startTag)+26
$end:=Position:C15($endTag; Substring:C12($1->; $start))
$0:=(Substring:C12($1->; $start; $end-1))