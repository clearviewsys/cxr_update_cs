//%attributes = {}
// selectDenomination(Currency;Denomination)


C_TEXT:C284($1; $denominationID)
C_REAL:C285($2)
READ ONLY:C145([Denominations:31])
$DenominationID:=makeDenominationsID($1; $2)
QUERY:C277([Denominations:31]; [Denominations:31]DenominationID:1=$denominationID)
