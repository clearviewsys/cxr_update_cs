C_POINTER:C301($showExpenseRdButtonPtr)
C_POINTER:C301($showIncomeRdButtonPtr)
C_LONGINT:C283($formMethod)
$formMethod:=Form event code:C388
Case of 
	: ($formMethod=On Clicked:K2:4)
		$showExpenseRdButtonPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "showExpenseRdButton")
		$showIncomeRdButtonPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "showIncomeRdButton")
		If ($showExpenseRdButtonPtr->=1)
			$showIncomeRdButtonPtr->:=0
		Else 
			$showIncomeRdButtonPtr->:=1
		End if 
End case 