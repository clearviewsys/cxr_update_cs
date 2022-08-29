//%attributes = {"shared":true}

//barclay's test for remote calls... not working as of yet
// see "remoteBackup" for example of handling soap calls and sending to another process
C_TEXT:C284($1; $tMethod)
C_TEXT:C284($0)

C_TEXT:C284($tTemp)
C_LONGINT:C283($iPos; $iProcess)

TRACE:C157

$tMethod:=$1
$iPos:=Position:C15("("; $tMethod)
If ($iPos>0)
	$tTemp:=Substring:C12($tMethod; 1; $iPos-1)
	$tTemp:=Replace string:C233($tTemp; "_"; "")
	$tMethod:=Substring:C12($tMethod; $iPos+1; Length:C16($tMethod))
	$tMethod:=Replace string:C233($tMethod; ")"; "")
	$tMethod:=Replace string:C233($tMethod; Char:C90(Double quote:K15:41); "")
	$tMethod:=Replace string:C233($tMethod; "("; "")
	$tMethod:=$tTemp+$tMethod
End if 

If (UTIL_isMethodExists($1)=True:C214)
	$iProcess:=Execute on server:C373($tMethod; 0; $tMethod)
	$0:="EXECUTING-"+$tMethod
Else 
	$0:="UNABLE TO EXECUTE: "+$tMethod
End if 