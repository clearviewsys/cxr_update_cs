//%attributes = {"publishedWeb":true}
// getYahooBidPrice(->HTML;->bid;->ask;->time)-> real
// unfinished procedure

C_POINTER:C301($1; $2; $3; $4)
C_LONGINT:C283($startMarker; $endMarker; $count)

$startMarker:=Position:C15("nowrap>"; $1->)+Length:C16("nowrap>")
$endMarker:=Position:C15("</th>"; Substring:C12($1->; $startMarker; 25))
$4->:=Substring:C12($1->; $startMarker; $endMarker-1)

$startMarker:=$startMarker+$endMarker  // advance marker
$count:=Position:C15("</td>"; Substring:C12($1->; $startMarker; 30))
$2->:=(Substring:C12($1->; $startMarker; $count))