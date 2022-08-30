//%attributes = {"shared":true}
C_LONGINT:C283($i; $n; $m)
READ WRITE:C146([MACs:18])
$m:=Num:C11(Request:C163("Please enter the LL quantum"; "30"; "Reconfig"; "Cancel"))

If (OK=1)
	ALL RECORDS:C47([MACs:18])
	$n:=Records in selection:C76([MACs:18])
	For ($i; 1; $n)
		GOTO SELECTED RECORD:C245([MACs:18]; $i)
		LOAD RECORD:C52([MACs:18])
		[MACs:18]ExpirationDate:2:=Current date:C33+$m
		[MACs:18]LaunchLimit:3:=[MACs:18]LaunchLimit:3+$m
		SAVE RECORD:C53([MACs:18])
		UNLOAD RECORD:C212([MACs:18])
	End for 
	READ ONLY:C145([MACs:18])
End if 