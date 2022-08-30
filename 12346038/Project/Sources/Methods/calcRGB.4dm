//%attributes = {}
// calcRGB (r; g; b) -> rgb value

C_LONGINT:C283($1; $2; $3; $0)
C_LONGINT:C283($Red; $Green; $Blue; $RGB)
$Red:=$1
$Green:=$2
$Blue:=$3

$RGB:=($Red << 16)+($Green << 8)+$Blue

$0:=$RGB
