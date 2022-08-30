//%attributes = {}
// scaleimage (->field; scale)
C_POINTER:C301($picturePtr; $1)
C_REAL:C285($scale; $2)

$picturePtr:=$1

If (Shift down:C543)
	If ($2>1)  //scale up
		$scale:=1+(2*Abs:C99(1-$2))
	Else 
		$scale:=1-(2*Abs:C99(1-$2))
	End if 
Else 
	$scale:=$2
End if 

C_REAL:C285($scale)

TRANSFORM PICTURE:C988($picturePtr->; Scale:K61:2; $scale; $scale)
CONVERT PICTURE:C1002($picturePtr->; ".jpg"; 0.6)
