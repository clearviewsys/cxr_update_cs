//%attributes = {}
// IdentityMind_status($text)
// Print the type of IdentityMind enviornment with description
// 
// Parameters:
// $text (Form Variable - C_TEXT)
//     the variable in the form to add the text
//
// Return: (NONE)

C_TEXT:C284($1; $text)  // text field to add the text

Case of 
	: (Count parameters:C259=1)
		$text:=$1
	Else 
		EXECUTE METHOD:C1007("assertInvalidNumberOfParams"; *; Current method name:C684; Count parameters:C259)
End case 
ASSERT:C1129(IdentityMindStage#"")

C_TEXT:C284($msg)
C_REAL:C285($color)
Case of 
	: (IdentityMindStage="sandbox")
		$msg:="Sandbox environment: For connection and debug purposes."
		$color:=0x00BDA800  // yellow
	: (IdentityMindStage="staging")
		$msg:="Staging environment: For configuring rules and profiles."
		$color:=0x00FF0000  // red
	Else   // (IdentityMindStage="edna")
		$msg:="Production environment: Do NOT use test data."
		$color:=0x00FFFFFF  // black
End case 

$0:=$msg
OBJECT SET RGB COLORS:C628(*; $text; $color; Disable highlight item color:K23:9)