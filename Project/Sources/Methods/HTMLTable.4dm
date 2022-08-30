//%attributes = {}
// HTMLTable (body;widthPercentage; border; spacing; padding) -> htmlText

C_LONGINT:C283($2; $3; $4; $5)
C_TEXT:C284($1; $0)
C_TEXT:C284($width; $border; $spacing; $padding)

If (Count parameters:C259=1)
	$width:=Quotify("100%")
	$border:=Quotify("0")
	$spacing:=Quotify("2")
	$padding:=Quotify("2")
Else 
	$width:=Quotify(String:C10($2))
	$border:=Quotify(String:C10($3))
	$spacing:=Quotify(String:C10($4))
	$padding:=Quotify(String:C10($5))
End if 

$0:="<table width="+$width+" border="+$border+" cellspacing="
$0:=$0+$spacing+" cellpadding="+$padding+">"+Char:C90(13)
$0:=$0+$1+Char:C90(13)
$0:=$0+"</table>"+Char:C90(13)