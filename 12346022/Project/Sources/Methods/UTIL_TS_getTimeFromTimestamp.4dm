//%attributes = {}
// returns time from longint timestamp set by calling UTIL_TS_getFromDate method
C_TIME:C306($0)
C_LONGINT:C283($1)

$0:=Time:C179(Time string:C180(?00:00:00?+($1%86400)))
