//%attributes = {}
// handleTristateCheckbox (self;->field; unchecked_state; checked_state; Mix_State; unchecked_colour ; checked colour; mix colour)
// form event; on load; on data change; on clicked

C_POINTER:C301($objectPtr; $fieldPtr; $1; $2)
C_TEXT:C284($yes_text; $no_text; $maybe_text; $3; $4; $5)
C_LONGINT:C283($yesColour; $noColour; $mixColour; $formEvent; $6; $7; $8; $9)

$yesColour:=Dark grey:K11:12
$noColour:=Dark grey:K11:12
$mixColour:=Dark grey:K11:12
$formEvent:=Form event code:C388

Case of 
	: (Count parameters:C259=2)
		$objectPtr:=$1
		$fieldPtr:=$2
		
	: (Count parameters:C259=5)
		$objectPtr:=$1
		$fieldPtr:=$2
		$no_text:=$3
		$yes_text:=$4
		$maybe_text:=$5
	: (Count parameters:C259=8)
		$objectPtr:=$1
		$fieldPtr:=$2
		$no_text:=$3
		$yes_text:=$4
		$maybe_text:=$5
		
		$noColour:=$6  // eg. red
		$yesColour:=$7  // e.g. blue
		$mixColour:=$8  // e.g. blue
		
	: (Count parameters:C259=9)
		
		$objectPtr:=$1
		$fieldPtr:=$2
		$no_text:=$3
		$yes_text:=$4
		$maybe_text:=$5
		
		$noColour:=$6  // eg. red
		$yesColour:=$7  // e.g. blue
		$mixColour:=$8  // e.g. blue
		$formEvent:=$9  // why do we have this form event param
		// reason: the checkbox object doesn't accept some form events such as on 'on outside call'
		// so we can force it to behave as if it can behave to it; for example when the object method
		// is called from the form method. In such a case, the form method can call the method and
		// send the desired form event to this method. 
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


Case of 
	: ($formEvent=On Load:K2:1)
		$objectPtr->:=$fieldPtr->
	: (($formEvent=On Clicked:K2:4) | ($formEvent=On Data Change:K2:15) | ($formEvent=On Outside Call:K2:11) | ($formEvent=On Printing Detail:K2:18))
		$fieldPtr->:=$objectPtr->
	Else 
		
End case 

If (Count parameters:C259>=5)  // set the object titles for 5 or 8 params
	C_LONGINT:C283($state)
	$state:=$objectPtr->
	Case of 
		: ($state=0)  // no-state
			OBJECT SET TITLE:C194($objectPtr->; $no_text)
		: ($state=1)  // yes-state
			OBJECT SET TITLE:C194($objectPtr->; $yes_text)
		: ($state=2)  // mix-state
			OBJECT SET TITLE:C194($objectPtr->; $maybe_text)
			
	End case 
End if 

If (Count parameters:C259>=8)  // set the foreground colours
	C_LONGINT:C283($state)
	$state:=$objectPtr->
	
	Case of 
		: ($state=0)  // no-state
			// _O_OBJECT SET COLOR($objectPtr->;-($noColour+(256*Light grey)))
			OBJECT SET RGB COLORS:C628($objectPtr->; convPalleteColourToRGB($noColour); convPalleteColourToRGB(Light grey:K11:13))
			
		: ($state=1)  // yes-state
			// _O_OBJECT SET COLOR($objectPtr->;-($yesColour+(256*Light grey)))
			OBJECT SET RGB COLORS:C628($objectPtr->; convPalleteColourToRGB($yesColour); convPalleteColourToRGB(Light grey:K11:13))
			
		: ($state=2)  // mix-state
			// _O_OBJECT SET COLOR($objectPtr->;-($mixColour+(256*Light grey)))
			OBJECT SET RGB COLORS:C628($objectPtr->; convPalleteColourToRGB($mixColour); convPalleteColourToRGB(Light grey:K11:13))
			
	End case 
End if 