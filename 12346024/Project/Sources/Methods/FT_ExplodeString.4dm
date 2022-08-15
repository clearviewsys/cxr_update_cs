//%attributes = {}
// FT_ExplodeString (text; separator; ->arrTokens)
// Explode string in n $tokens separated by $separator

// Unit test: @Zoya - 18 Jun 2021

C_TEXT:C284($1; $text; $2; $separator; $token)
C_POINTER:C301($3; $arrPtr)
C_LONGINT:C283($p)

Case of 
	: (Count parameters:C259=3)
		
		$text:=$1
		$separator:=$2
		$arrPtr:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (Length:C16($text)>0)
	
	Repeat 
		
		$p:=Position:C15($separator; $text)
		
		If ($p>0)
			$token:=Substring:C12($text; 1; $p-1)
			APPEND TO ARRAY:C911($arrPtr->; $token)
			$text:=Substring:C12($text; $p+1)
		Else 
			APPEND TO ARRAY:C911($arrPtr->; $text)
			$text:=""
		End if 
		
	Until ($text="")
	
	
End if 
