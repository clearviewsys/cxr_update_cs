//%attributes = {}
C_TEXT:C284($phone; $code; $part1; $part2)
$phone:=$1
$code:=Substring:C12($phone; 1; 3)
$part1:=Substring:C12($phone; 4; 3)
$part2:=Substring:C12($phone; 7; 4)
OPEN URL:C673("http://wp1.superpages.ca/wp/results.phtml?SRC=ca&STYPE=WR&PS=15&PI=1&A="+$code+"&X="+$part1+"&P="+$part2+"&search=Find"; *)
//http://wp1.superpages.ca/wp/results.phtml?SRC=ca&STYPE=WR&PS=15&PI=1&A="+$CODE+"&X="+$PART1+"&P="+$PART2+"&search=Find"

// http://findaperson.canada-411.ca/search/FindPerson?firstname=tiran&name=behrouz