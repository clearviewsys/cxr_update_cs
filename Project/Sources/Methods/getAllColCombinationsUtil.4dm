//%attributes = {}
#DECLARE($n : Integer; $left : Integer; $k : Integer; $ans : Collection; $tmp : Collection; $col : Collection)

var $i : Integer

If ($k=0)
	$ans.push($tmp.copy())
End if 

For ($i; $left; $n)
	$tmp.push($col[$i-1])
	getAllColCombinationsUtil($n; $i+1; $k-1; $ans; $tmp; $col)
	$tmp.pop()
End for 
