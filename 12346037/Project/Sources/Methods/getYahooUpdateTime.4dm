//%attributes = {"publishedWeb":true}
// getYahooBidPrice(->HTML)-> real

C_POINTER:C301($1)
C_TEXT:C284($0)
C_LONGINT:C283($start; $end)

$start:=Position:C15("nowrap>"; $1->)+Length:C16("nowrap>")
$end:=Position:C15("</th>"; Substring:C12($1->; $start; 25))
$0:=(Substring:C12($1->; $start; $end-1))