//%attributes = {}
// selectDenomination(Currency;Denomination)

C_TEXT:C284($1; $denominationID)
C_REAL:C285($2)
READ ONLY:C145([Denominations:31])
$DenominationID:=makeDenominationsID($1; $2)
C_LONGINT:C283($found)
C_BOOLEAN:C305($0)
SET QUERY DESTINATION:C396(Into variable:K19:4; $found)
QUERY:C277([Denominations:31]; [Denominations:31]DenominationID:1=$denominationID)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

If ($found>0)
	$0:=True:C214
Else 
	$0:=False:C215
End if 
