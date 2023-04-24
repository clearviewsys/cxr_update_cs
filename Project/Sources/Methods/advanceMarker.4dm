//%attributes = {"publishedWeb":true}
// advanceMarker(->string;->marker;->tag) ->positionCount
// looksup for the tag in the string 
// starting from the marker and advances the marker
// returns the position of the tag

C_LONGINT:C283($0)
C_POINTER:C301($1; $2; $3)
C_LONGINT:C283($0)

$0:=Position:C15($3->; Substring:C12($1->; $2->))  // find the tag
$2->:=$2->+$0
