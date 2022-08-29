//%attributes = {}
// returns date from longint timestamp set by calling UTIL_TS_getFromDate method

C_DATE:C307($0; $seeddate)
C_LONGINT:C283($1)

$seeddate:=Add to date:C393(!00-00-00!; 2000; 1; 1)

$0:=$seeddate+($1\86400)
