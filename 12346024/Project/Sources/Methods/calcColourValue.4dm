//%attributes = {}
// calcColourValue (foreground; background)

C_LONGINT:C283($1; $2; $0; $foreground; $background; $result)

$foreground:=$1
$background:=$2

$result:=-($foreground+(256*$background))

$0:=$result