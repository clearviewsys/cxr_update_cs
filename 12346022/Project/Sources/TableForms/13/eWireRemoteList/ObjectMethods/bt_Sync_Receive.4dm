var $iError : Integer

$iError:=getRemoteEwireList

If ($iError=0)
	SET TIMER:C645(15*60*60)
End if 