//%attributes = {}
// UTL_lowerCamelCase

C_TEXT:C284($0; $vt_textOut)
C_TEXT:C284($1; $vt_textIn; $vt_part)

$vt_textOut:=""
$vt_textIn:=$1

If (Length:C16($vt_textIn)>0)
	
	C_COLLECTION:C1488($c_explode)
	$c_explode:=Split string:C1554(Replace string:C233($vt_textIn; "_"; " "; *); " "; sk ignore empty strings:K86:1+sk trim spaces:K86:2)
	
	For each ($vt_part; $c_explode)
		If (Length:C16($vt_textOut)=0)
			$vt_textOut:=Lowercase:C14($vt_part)
		Else 
			$vt_textOut:=$vt_textOut+Uppercase:C13($vt_part[[1]])+Lowercase:C14(Substring:C12($vt_part; 2))
		End if 
	End for each 
	
End if 

$0:=$vt_textOut