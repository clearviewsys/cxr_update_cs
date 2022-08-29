C_LONGINT:C283($row)

$row:=arrQty
If ($row>0)
	DELETE FROM ARRAY:C228(arrQty; $row)
	DELETE FROM ARRAY:C228(arrDenomination; $row)
	DELETE FROM ARRAY:C228(arrTotal; $row)
Else 
	ALERT:C41("Please select a row to delete.")
End if 