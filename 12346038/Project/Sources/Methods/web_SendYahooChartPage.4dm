//%attributes = {"publishedWeb":true}
C_TEXT:C284($1; $str; $url)
$str:=Substring:C12($1; 2)
$url:=getYahooChartURL($str)
WEB SEND HTTP REDIRECT:C659($url; *)