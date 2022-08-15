//%attributes = {}

C_LONGINT:C283($0)
C_POINTER:C301($1; $ptrArray)
C_TEXT:C284($2; $branchCode)
C_LONGINT:C283($i; $p; $j)

$ptrArray:=$1
$branchCode:=$2

ARRAY TEXT:C222($tmpArr; 0)
COPY ARRAY:C226($ptrArray->; $tmpArr)

$p:=Find in array:C230($tmpArr; $branchCode)
$j:=0

If ($p>0)
	
	For ($i; $p; Size of array:C274($tmpArr))
		
		If ($tmpArr{$i}#$branchCode)
			$i:=Size of array:C274($tmpArr)+1
		Else 
			$j:=$j+1
		End if 
		
	End for 
	
End if 


$0:=$j




