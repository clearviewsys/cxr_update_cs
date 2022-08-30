//%attributes = {}
// handlePhoneField(self)
// this method formats the field as a phone number
// OBJECT EVENTS: On Data Change

C_POINTER:C301($1; $varPtr)
$varPtr:=$1
C_TEXT:C284($text)
$text:=$varPtr->
Case of 
	: ((Length:C16($text)=10) & (Position:C15("-"; $text)=0))  // 604-922-9151
		OBJECT SET FORMAT:C236($varPtr->; "(###) ###-####")
		
	: ((Length:C16($varPtr->)=11) & (Position:C15("-"; $text)=0) & (Position:C15("1"; $text)=1))
		OBJECT SET FORMAT:C236($varPtr->; "# (###) ###-####")  // 1 (604) 922 9151
		
	: ((Length:C16($varPtr->)=12) & (Position:C15("-"; $text)=0) & (Position:C15("+1"; $text)=1))  // +1 (604) 922-9151
		OBJECT SET FORMAT:C236($varPtr->; "+# (###) ###-####")
		
	: ((Length:C16($varPtr->)=13) & (Position:C15("-"; $text)=0) & (Position:C15("+9821"; $text)=1))  // +98 (21) 1111-2222
		OBJECT SET FORMAT:C236($varPtr->; "+## (##) ####-####")
		
	: ((Length:C16($varPtr->)=13) & (Position:C15("-"; $text)=0) & (Position:C15("+9891"; $text)=1))  // +98 (912) 111-2222
		OBJECT SET FORMAT:C236($varPtr->; "+## (###) ###-####")
		
		// new zealand
	: ((Length:C16($varPtr->)=12) & (Position:C15("-"; $text)=0) & (Position:C15("+64"; $text)=1))  // +64 (22) 111-2222
		OBJECT SET FORMAT:C236($varPtr->; "+## (##) ### ####")
	: ((Length:C16($varPtr->)=11) & (Position:C15("-"; $text)=0) & (Position:C15("64"; $text)=1))  // +64 (22) 111-2222
		OBJECT SET FORMAT:C236($varPtr->; "+## (##) ### ####")
		//: ((Length($varPtr->)=10) & (Position("-";$text)=0) & (Position("64";$text)=1))  ` +64 (22) 111-2222
		//SET FORMAT($varPtr->;"+## (##) ### ###")
	: ((Length:C16($varPtr->)=9) & (Position:C15("-"; $text)=0) & (Position:C15("0"; $text)=1))  // +64 (22) 111-2222
		OBJECT SET FORMAT:C236($varPtr->; "## ### ####")
		
	Else 
		//if (length($text)=length(<>defaultPhoneFormat))
		//OBJECT SET FORMAT($varPtr->;<>defaultPhoneFormat)
		//Else 
		OBJECT SET FORMAT:C236($varPtr->; "")
		//end if
End case 