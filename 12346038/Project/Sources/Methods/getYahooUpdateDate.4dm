//%attributes = {"publishedWeb":true}
// getYahooUpdateDate (->HTML)-> DateText


C_POINTER:C301($1)
C_TEXT:C284($0; $startTag)
C_TEXT:C284($startTag; $endTag)

C_LONGINT:C283($start; $end)
$startTag:="<td align="+Quotify("Center")+"><small>"
$endTag:="</small>"

$start:=Position:C15($startTag; $1->)+Length:C16($startTag)+0
$end:=Position:C15($endTag; Substring:C12($1->; $start))

$0:=(Substring:C12($1->; $start; $end-1))