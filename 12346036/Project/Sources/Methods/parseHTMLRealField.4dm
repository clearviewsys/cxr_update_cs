//%attributes = {"publishedWeb":true}
//CrawlHTMLforRealField (»HTMLText;TitleText;Offset;Length)->Real

// Crawl the HTML text for titletext ...

// Add the offset to position and parse the number from the given length


C_POINTER:C301($1)
// $1 must be a pointer to a text

C_TEXT:C284($2)
C_LONGINT:C283($3; $4)
C_REAL:C285($0)

C_LONGINT:C283($i)

$i:=Position:C15($2; $1->)
$0:=Num:C11(Substring:C12($1->; $i+Length:C16($2)+$3; $4))