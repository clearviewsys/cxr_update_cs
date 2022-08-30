//%attributes = {}
// get random string with random length between $1 and $2
//

C_TEXT:C284($0; $randomstr)
C_LONGINT:C283($1; $MinLength)
C_LONGINT:C283($2; $Maxlength)
C_TEXT:C284($chars)
C_LONGINT:C283($i; $randomlength; $whichchar)

If (Count parameters:C259>0)
	$MinLength:=$1
	If (Count parameters:C259>1)
		$Maxlength:=$2
	Else 
		$Maxlength:=$MinLength+8
	End if 
Else 
	$MinLength:=4
	$Maxlength:=8
End if 

$chars:="0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
$randomstr:=""

$randomlength:=(Random:C100%($Maxlength-$MinLength+1))+$MinLength

For ($i; 1; $randomlength)
	
	$whichchar:=Random:C100%(Length:C16($chars))+1
	$randomstr:=$randomstr+$chars[[$whichchar]]
	
End for 


$0:=$randomstr
