//%attributes = {}
C_LONGINT:C283($win)
C_DATE:C307(vDate)

$win:=Open form window:C675("Test"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
C_OBJECT:C1216($o)
$o:=New object:C1471
$o.email:=""
$o.password:=""

DIALOG:C40("Test"; $o)
$o.email:=""

DIALOG:C40("Test"; $o)

If ($o.password="2345")
	ALERT:C41(String:C10(vDate))
	
End if 

