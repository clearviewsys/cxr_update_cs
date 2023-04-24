//%attributes = {}
// getClientBrowserFormName({ClientName}) -> browserFormName
// get current client browser form name

#DECLARE->$default : Text

// C_TEXT($0; $default)

selectClientPrefsRecord

$default:="Browser"

If (Records in selection:C76([ClientPrefs:26])=1)
	
	Case of 
			
		: ([ClientPrefs:26]browserForm:24=0)
			// $0:=$default
			
		: ([ClientPrefs:26]browserForm:24=1)
			$default:=$default+"_simple"
			
		: ([ClientPrefs:26]browserForm:24=2)
			$default:=$default+"_medium"
			
		: ([ClientPrefs:26]browserForm:24=3)
			$default:=$default+"_Full"
			
		: ([ClientPrefs:26]browserForm:24=4)
			$default:=$default+"_Custom"
			
	End case 
	
End if 