//%attributes = {}
// getCleitnChequeFrom({ClientName}) -> cheque form name to print
// 

C_TEXT:C284($0; $default)
selectClientPrefsRecord
$default:="printCheque"
If (Records in selection:C76([ClientPrefs:26])=1)
	Case of 
		: ([ClientPrefs:26]chequeFormat:28=0)
			$0:=$default
			
		: ([ClientPrefs:26]chequeFormat:28=1)
			$0:=$default+"_computer"
			
		: ([ClientPrefs:26]chequeFormat:28=2)
			$0:=$default+"_computer2"
			
		Else 
			$0:=$default
	End case 
Else 
	$0:=$default
End if 