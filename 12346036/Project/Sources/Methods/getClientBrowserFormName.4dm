//%attributes = {}
// getClientBrowserFormName({ClientName}) -> browserFormName
// get current client browser form name

C_TEXT:C284($0; $default)
selectClientPrefsRecord
$default:="Browser"
If (Records in selection:C76([ClientPrefs:26])=1)
	Case of 
		: ([ClientPrefs:26]browserForm:24=0)
			$0:=$default
			
		: ([ClientPrefs:26]browserForm:24=1)
			$0:=$default+"_simple"
			
		: ([ClientPrefs:26]browserForm:24=2)
			$0:=$default+"_medium"
			
		: ([ClientPrefs:26]browserForm:24=3)
			$0:=$default+"_Full"
			
		: ([ClientPrefs:26]browserForm:24=4)
			$0:=$default+"_Custom"
		Else 
			$0:=$default
	End case 
Else 
	$0:=$default
End if 