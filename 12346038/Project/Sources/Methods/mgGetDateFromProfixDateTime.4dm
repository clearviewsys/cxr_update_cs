//%attributes = {}
C_DATE:C307($0)
C_LONGINT:C283($d; $m; $y; $posd; $posy; $posm)
C_TEXT:C284($1; $dateTime)

$dateTime:=$1
$0:=!00-00-00!

$posd:=Position:C15("."; $dateTime)

If ($posd>0)
	
	$d:=Num:C11(Substring:C12($dateTime; 1; $posd-1))
	$dateTime:=Substring:C12($dateTime; $posd+1)
	
	$posm:=Position:C15("."; $dateTime)
	
	If ($posm>0)
		
		$m:=Num:C11(Substring:C12($dateTime; 1; $posm-1))
		$dateTime:=Substring:C12($dateTime; $posm+1)
		
		$posy:=Position:C15("+"; $dateTime)
		
		If ($posy>0)
			
			$y:=Num:C11(Substring:C12($dateTime; 1; $posy-1))
			
			$0:=Add to date:C393(!00-00-00!; $y; $m; $d)
			
		End if 
		
	End if 
	
End if 
