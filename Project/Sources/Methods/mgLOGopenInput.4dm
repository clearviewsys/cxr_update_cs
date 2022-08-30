//%attributes = {}
C_OBJECT:C1216($1; $obj)
C_LONGINT:C283($winref)

$obj:=$1

$winref:=Open form window:C675("mgLOGanalyzerDetail")

DIALOG:C40("mgLOGanalyzerDetail"; $obj)

CLOSE WINDOW:C154

