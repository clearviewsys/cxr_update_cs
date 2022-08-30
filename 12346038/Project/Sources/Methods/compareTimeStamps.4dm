//%attributes = {}
// compareTimeStamps (strTimestamp1;strTimestamp2)
C_TEXT:C284($1; $strDate1; $2; $strDate2)

$strDate1:=$1
$strDate2:=$2

C_DATE:C307($date1; $date2)
C_BOOLEAN:C305($ok)

C_TEXT:C284($vt)
C_COLLECTION:C1488($col1; $col2)
$col1:=New collection:C1472
$col1:=Split string:C1554($1; "-"; sk ignore empty strings:K86:1+sk trim spaces:K86:2)
$ok:=PHP Execute:C1058(""; "strtotime"; $strDate1; $col1[0]+" "+$col1[1])

//DELAY PROCESS(Current process;60)

$col2:=Split string:C1554($2; "-"; sk ignore empty strings:K86:1+sk trim spaces:K86:2)
$ok:=PHP Execute:C1058(""; "strtotime"; $strDate2; $col2[0]+" "+$col2[1])

If ($strDate1>$strDate2)
	$0:=True:C214
Else 
	$0:=False:C215
End if 







