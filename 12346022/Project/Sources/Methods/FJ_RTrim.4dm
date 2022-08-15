//%attributes = {}

// FJ_RTrim
// Unit test written @Zoya 07 Mar 2021
C_TEXT:C284($0)
C_TEXT:C284($1; $str)
C_LONGINT:C283($i; $p; $j)

$str:=$1
$i:=Length:C16($str)
$p:=-1

If (Length:C16($str)>0)
	
	For ($j; $i; 1; -1)
		
		If (Substring:C12($str; $j; 1)#" ")
			$p:=$j
			$j:=-1
		End if 
		
	End for 
	
	If ($p>0)
		$0:=Substring:C12($str; 1; $p)
	Else 
		$0:=Substring:C12($str; 1; $j)
	End if 
	
Else 
	$0:=""
End if 

