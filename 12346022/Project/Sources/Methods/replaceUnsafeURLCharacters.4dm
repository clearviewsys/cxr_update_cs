//%attributes = {}
// replaceUnsafeURLCharacters($text)
//
// replaces the unsafe and reserved URL character with encoding characters
// 
// Parameters:
// $text (C_TEXT)
//   the unsafe url string
//
// Return: (C_TEXT)
//   the safe URL string
// Author: Wai-Kin

C_TEXT:C284($1; $text)
C_TEXT:C284($0; $result)

Case of 
	: (Count parameters:C259=1)
		$text:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$result:=""
C_LONGINT:C283($i)
For ($i; 1; Length:C16($text))
	C_TEXT:C284($char)
	$char:=Substring:C12($text; $i; 1)
	Case of 
		: ($char="!")
			$result:=$result+"%21"
		: ($char="#")
			$result:=$result+"%23"
		: ($char="$")
			$result:=$result+"%24"
		: ($char="%")
			$result:=$result+"%25"
		: ($char="&")
			$result:=$result+"%26"
		: ($char="'")
			$result:=$result+"%27"
		: ($char="(")
			$result:=$result+"%28"
		: ($char=")")
			$result:=$result+"%29"
		: ($char="*")
			$result:=$result+"%2A"
		: ($char="+")
			$result:=$result+"%2B"
		: ($char=",")
			$result:=$result+"%2C"
		: ($char="/")
			$result:=$result+"%2F"
		: ($char=":")
			$result:=$result+"%3A"
		: ($char=";")
			$result:=$result+"%3B"
		: ($char="=")
			$result:=$result+"%3D"
		: ($char="?")
			$result:=$result+"%3F"
		: (Character code:C91($char)=Character code:C91("@"))
			$result:=$result+"%40"
		: ($char="[")
			$result:=$result+"%5B"
		: ($char="]")
			$result:=$result+"%5D"
		: ($char=" ")
			$result:=$result+"%20"
		: ($char="\"")
			$result:=$result+"%22"
		: ($char="<")
			$result:=$result+"%3C"
		: ($char=">")
			$result:=$result+"%3E"
		: ($char="#")
			$result:=$result+"%23"
		: ($char="%")
			$result:=$result+"%25"
		: ($char="{")
			$result:=$result+"%7B"
		: ($char="}")
			$result:=$result+"%7D"
		: ($char="|")
			$result:=$result+"%7C"
		: ($char="\\")
			$result:=$result+"%5C"
		: ($char="^")
			$result:=$result+"%5E"
		: ($char="~")
			$result:=$result+"%7E"
		: ($char="[")
			$result:=$result+"%5B"
		: ($char="]")
			$result:=$result+"%5D"
		: ($char="`")
			$result:=$result+"%60"
		Else 
			$result:=$result+$char
	End case 
End for 
$0:=$result