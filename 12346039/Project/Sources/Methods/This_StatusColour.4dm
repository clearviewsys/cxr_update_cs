//%attributes = {}
C_LONGINT:C283($0; $1; $status; $colour; $r; $g; $b)

$status:=$1

Case of 
	: ($status=0)  // untouched
		$r:=255
		$g:=190
		$b:=$g
	: ($status=1)  // resolved
		$r:=200
		$g:=250
		$b:=$r
		
	: ($status=2)  // unresolved
		$r:=210
		$g:=$r
		$b:=$r
	Else 
		$0:=-1
End case 
$colour:=($r << 16)+($g << 8)+$b

$0:=$colour