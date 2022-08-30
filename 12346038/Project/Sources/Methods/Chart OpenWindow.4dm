//%attributes = {"publishedWeb":true}
// Chart openWindow (Width; height ; type ; title )-> longint
// opens a window for charting purpose and returns the area number

C_LONGINT:C283($0)

C_LONGINT:C283($1; $2; $3)
C_TEXT:C284($4)

//$0:=_O_Open external window((Screen width-$1)/2;(Screen height-$2)/2;(Screen width-$1)/2+$1;(Screen height-$2)/2+$2;$3;$4;"_4d Chart")