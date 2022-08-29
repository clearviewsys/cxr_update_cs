C_LONGINT:C283(vMinutes)
If (vMinutes><>minUpdateTime)
	vMinutes:=vMinutes-1
	<>updateFrequency:=vMinutes
	SET TIMER:C645(vMinutes*60*60)
End if 
