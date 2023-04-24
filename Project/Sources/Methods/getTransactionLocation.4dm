//%attributes = {}
C_TEXT:C284($0; $tmp)

$tmp:=Replace string:C233([Branches:70]BranchName:2+", "+[Branches:70]Address:3+", "+[Branches:70]City:4; Char:C90(CR ASCII code:K15:14); "")
If (([Branches:70]Address:3="") | ([Branches:70]City:4=""))
	$tmp:=Replace string:C233($tmp; ", "; "")
End if 

$tmp:=Replace string:C233($tmp; Char:C90(LF ASCII code:K15:11); "")

$0:=$tmp
