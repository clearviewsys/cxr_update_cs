If (Form event code:C388=On Clicked:K2:4)
	acc_initGridFormVars
	var $col : Collection
	var $i : Text
	var $ptr : Pointer
	$col:=New collection:C1472("dd_Till"; "dd_CCY"; "dd_MainAccounID"; "dd_AccountType"; "dd_Agent"; "dd_user"; "dd_branch"; "dd_subAccountID")
	For each ($i; $col)
		$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; $i)
		If (Not:C34(Is nil pointer:C315($ptr)))
			$ptr->:=1  // reset to first item in the list
		End if 
	End for each 
End if 