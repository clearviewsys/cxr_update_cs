//%attributes = {}
// handleCurrencyObject(self)

C_POINTER:C301($objectPtr; $1; $DateFieldPtr)
$objectPtr:=$1

C_TEXT:C284($Keystroke)

$DateFieldPtr:=$1

Case of 
	: (Form event code:C388=On Before Keystroke:K2:6)
		$Keystroke:=Keystroke:C390
		
		Case of   // Check to see if a "function" key is hit
			: ($Keystroke="C")  // 
				//$objectPtr->:=◊baseCurrency
				//HIGHLIGHT TEXT($objectPtr;1;3)
				//FILTER KEYSTROKE("")
		End case 
		
	: (Form event code:C388=On Data Change:K2:15)  // Interpret the entry
		//$DateFieldPtr->:=convStringToDate (Get edited text)
End case 
pickCurrency($objectPtr)
