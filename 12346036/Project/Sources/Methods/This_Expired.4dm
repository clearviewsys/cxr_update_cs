//%attributes = {}

C_DATE:C307($date)

C_LONGINT:C283($0; $1; $status; $colour; $r; $g; $b)
C_BOOLEAN:C305($isExpired)


$date:=[MACs:18]ExpirationDate:2
$isExpired:=isDateExpired($date)

Case of 
	: ($isExpired)  // untouched
		$r:=255
		$g:=200
		$b:=200
	Else 
		$r:=255
		$g:=255
		$b:=255
End case 
$colour:=($r << 16)+($g << 8)+$b

$0:=$colour