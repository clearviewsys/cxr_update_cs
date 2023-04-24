//%attributes = {}
// toTitlecase(->stringPtr)->string
// e.g. toTitlecase(self)
//String - item to be changed to titlecase


C_LONGINT:C283($i; $j)
C_TEXT:C284($0; $string)
C_POINTER:C301($self)
Case of 
	: (Count parameters:C259=0)
		$string:="hello"
		$self:=->$string
	: (Count parameters:C259=1)
		$self:=$1
		$string:=$1->  // dereference the self pointer
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (Length:C16($string)>0)
	$string[[1]]:=Uppercase:C13($string[[1]])
	If (Length:C16($string)>1)
		For ($i; 1; Length:C16($string)-1)
			If (($string[[$i]]=" ") | ($string[[$i]]="-"))
				$string[[$i+1]]:=Uppercase:C13($string[[$i+1]])
			End if 
		End for 
		If ((Position:C15("Mc"; $string)=1) | (Position:C15("'"; $string)=2)) & (Length:C16($string)>2)
			$string[[3]]:=Uppercase:C13($string[[3]])
		End if 
	End if 
End if 

$self->:=$string
$0:=$string
