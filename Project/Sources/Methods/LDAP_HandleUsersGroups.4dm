//%attributes = {}
C_OBJECT:C1216($obj)
C_LONGINT:C283($winref)

$obj:=New object:C1471

$winref:=Open form window:C675("ADTEST")

DIALOG:C40("ADTEST"; $obj)

CLOSE WINDOW:C154
