//%attributes = {}
C_POINTER:C301($1; $self)

C_LONGINT:C283($n; $R; $G; $B; $RGB)
$self:=$1

$n:=$self->

Case of 
	: ($n=0)
		$R:=255
		$G:=255
		$B:=255
	: ($n=1)
		$R:=230
		$G:=240-100
		$B:=240
	: ($n=2)
		$R:=230-100
		$G:=240-100
		$B:=240
	Else 
		$R:=255
		$G:=255
		$B:=255
End case 

$RGB:=($R*256*256)+($G*256)+$B
OBJECT SET RGB COLORS:C628($Self->; 127; $RGB)