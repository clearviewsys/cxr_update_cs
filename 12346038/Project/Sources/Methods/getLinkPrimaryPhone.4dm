//%attributes = {}
C_TEXT:C284($0)

If ([Links:17]MainPhone:8#"")
	$0:=[Links:17]MainPhone:8
Else 
	If ([Links:17]HomePhone:6#"")
		$0:=[Links:17]HomePhone:6
	Else 
		$0:=[Links:17]SecondaryPhone:7
	End if 
End if 
