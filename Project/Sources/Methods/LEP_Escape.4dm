//%attributes = {}
C_TEXT:C284($1; $param; $0; $metacharacters; $metacharacter)
C_LONGINT:C283($i)

If (Count parameters:C259#0)
	
	$param:=$1
	
	If (Is macOS:C1572)
		$metacharacters:="\\!\"#$%&'()=~|<>?;*`[] "
		For ($i; 1; Length:C16($metacharacters))
			$metacharacter:=Substring:C12($metacharacters; $i; 1)
			$param:=Replace string:C233($param; $metacharacter; "\\"+$metacharacter; *)
		End for 
	End if 
End if 

$0:=$param