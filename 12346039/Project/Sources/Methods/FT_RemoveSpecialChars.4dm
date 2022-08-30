//%attributes = {}
// FT_removeSpecialChars ($fromString)

C_TEXT:C284($1; $fromString)
C_TEXT:C284($0)
C_LONGINT:C283($c; $i)

Case of 
	: (Count parameters:C259=1)
		$fromString:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


For ($i; 1; Length:C16($fromString))
	$c:=Character code:C91(Substring:C12($fromString; $i; 1))
	
	
	Case of 
			
		: ($c<32)
			// reject it
			$fromString:=Replace string:C233($fromString; Char:C90($c); " ")
			
		: ($c>127)
			// reject it
			$fromString:=Replace string:C233($fromString; Char:C90($c); " ")
			
			// Allows: Double quote (32), # (35), Single quote (39),  Comma(44), Period(46), Slash(47)
		: (($c=32) | ($c=35) | ($c=39) | ($c=44) | ($c=46) | ($c=47))
			// Do nothing no special chars detected
			
		: (($c>=58) & ($c<=64))
			// Deny:  Colon (58), Semicolon (59), Less than (60), Equality sign (61),  Greater than(62), Question mark(63), At sign(64)
			// replace special characters with space
			$fromString:=Replace string:C233($fromString; Char:C90($c); " ")
			
		: (($c>=91) & ($c<=94))
			// Deny: Left square bracket (91), Backslash (92), Right square bracket (93), Caret / circumflex (^)
			// replace special characters with space
			$fromString:=Replace string:C233($fromString; Char:C90($c); " ")
			
		: (($c=96) | ($c=32) | ($c=10) | ($c=43))
			// Deny: Grave / accent (96), Carriage Return (32), Line Feed (10), Plus (43)
			// replace special characters with space
			$fromString:=Replace string:C233($fromString; Char:C90($c); " ")
			
		: (($c>=123) & ($c<=127))
			//Deny: Left curly bracket (123), Vertical bar(124), Right curly bracket(125), Tilde ~ (126),  DEL (127)
			// replace special characters with space
			$fromString:=Replace string:C233($fromString; Char:C90($c); " ")
			
		Else 
			// Do nothing no special chars detected
			
	End case 
	
	
End for 


$0:=FJ_Trim($fromString)





