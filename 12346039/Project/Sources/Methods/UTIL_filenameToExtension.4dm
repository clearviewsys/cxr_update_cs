//%attributes = {}

C_TEXT:C284($1; $filename)

C_TEXT:C284($0; $extension)

C_LONGINT:C283($i)

$filename:=$1
$extension:=""

For ($i; Length:C16($filename); 1; -1)
	
	If (Character code:C91($filename[[$i]])=Period:K15:45)
		$extension:=Substring:C12($filename; $i+1; Length:C16($filename))
		$i:=0
	End if 
	
End for 

$0:=$extension
