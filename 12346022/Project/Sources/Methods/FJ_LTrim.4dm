//%attributes = {}
// FJ_LTrim
//Unit Test Written @Zoya 07 Mar 2021

C_TEXT:C284($0)
C_TEXT:C284($1; $str)
C_LONGINT:C283($i; $j; $p)

$str:=$1

$j:=Length:C16($str)
$p:=-1

If (Length:C16($str)>0)
	
	For ($i; 1; $j)
		
		If (Substring:C12($1; $i; 1)#" ")
			$p:=$i
			$i:=$j+1
		End if 
		
	End for 
	
	If ($p>0)
		$0:=Substring:C12($str; $p; $j)
	Else 
		$0:=Substring:C12($str; 1; $j)
	End if 
	
Else 
	$0:=""
End if 

