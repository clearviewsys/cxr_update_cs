//%attributes = {}

// ------------------------------------------------------------------------------
// Method: FT_StringFormat: 
// Format a string returning String filled with a pad 
// 
// Parameters: 
//   $1: String to format  (Input - String) 
//   $2: Pad length   (Input - Number) 
//   $3: Pad String (default = " ")   (Input - String)  (optional)
//   $4: Alignment: LJ | RJ | CE  (LJ: left default)| RJ: Right Just | CE: Center (Input - text)  (optional)
//
// Return:
//   $0: Number formated  (Output - String)
// ------------------------------------------------------------------------------
// Jaime Alvarez, 12/07/2015
// ------------------------------------------------------------------------------

C_TEXT:C284($1)
C_LONGINT:C283($2)  // Pad Length
C_TEXT:C284($3)  // Pad String
C_TEXT:C284($4)  // Alignment

C_TEXT:C284($0)
C_TEXT:C284($fmt)
C_BOOLEAN:C305($isOk)

C_LONGINT:C283($param; $alignToLeft; $alignToRight; $alignToCenter)
C_TEXT:C284($padString)
$param:=Count parameters:C259

$alignToLeft:=1  // Align string Left 123xxxx. where 'x' is the pad
$alignToRight:=0  // Align string rigth xxxx123
$alignToCenter:=2  // Align string to center xxx123xxxx

$padString:=" "

Case of 
		
	: ($param=2)
		
		$isOK:=PHP Execute:C1058(""; "str_pad"; $fmt; $1; $2; $padString; $alignToLeft)
		
	: ($param=3)
		
		$padString:=$3
		$isOK:=PHP Execute:C1058(""; "str_pad"; $fmt; $1; $2; $padString; $alignToLeft)
		
	: ($param=4)
		
		$padString:=$3
		
		Case of 
			: (Lowercase:C14($4)="LJ")
				$isOK:=PHP Execute:C1058(""; "str_pad"; $fmt; $1; $2; $padString; $alignToLeft)
				
			: (Lowercase:C14($4)="RJ")
				$isOK:=PHP Execute:C1058(""; "str_pad"; $fmt; $1; $2; $padString; $alignToRight)
				
			: (Lowercase:C14($4)="CE")
				$isOK:=PHP Execute:C1058(""; "str_pad"; $fmt; $1; $2; $padString; $alignToCenter)
				
		End case 
		
End case 

If ($isOk)
	$0:=Substring:C12($fmt; 1; $2)
Else 
	$0:=""
End if 

