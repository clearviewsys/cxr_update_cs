//%attributes = {}

// ------------------------------------------------------------------------------
// Method: FT_Number : 
// Format a number returning a String filled with a pad 
// 
// Parameters: 
//   $1: Number to format  (Input - Number) 
//   $2: Number of decimals required - 0: Number as is-  (Input - Number)
//   $3: Pad length   (Input - Number) 
//   $4: Pad String (default = "0")   (Input - String)  (optional)
//   $5: Number Alignment: LJ | RJ (default) | CE (Input - text)  (optional)
//
// Return:
//   $0: Number formated  (Output - String)
// ------------------------------------------------------------------------------
// Jaime Alvarez, 12/07/2015
// ------------------------------------------------------------------------------

C_REAL:C285($1)
C_LONGINT:C283($2)  // Decimal Places
C_LONGINT:C283($3)  // Pad Length
C_TEXT:C284($4)  // Pad String
C_TEXT:C284($5)  // Alignment

C_TEXT:C284($0)
C_TEXT:C284($fmt; $padString; $strValue)
C_BOOLEAN:C305($isOk)
C_LONGINT:C283($param; $alignToLeft; $alignToRight; $alignToCenter; $p)
$isOk:=False:C215


$param:=Count parameters:C259

$alignToLeft:=0  // Align number Left 123xxxx. where 'x' is the pad
$alignToRight:=1  // Align number rigth xxxx123
$alignToCenter:=2  // Align number to center xxx123xxxx

$padString:="0"
$p:=Position:C15("."; String:C10($1))
$strValue:=String:C10($1)

If ($2>0)
	
	If ($p>0)
		$strValue:=String:C10(Trunc:C95($1; $2))
	Else 
		$strValue:=String:C10($1)+".00"
	End if 
	
End if 


Case of 
		
	: ($param=2)
		
		$isOK:=PHP Execute:C1058(""; "str_pad"; $fmt; $strValue; $3; $padString; $alignToRight)
		
	: ($param=3)
		
		$isOK:=PHP Execute:C1058(""; "str_pad"; $fmt; $strValue; $3; $padString; $alignToRight)
		
	: ($param=4)
		
		$padString:=$4
		$isOK:=PHP Execute:C1058(""; "str_pad"; $fmt; $strValue; $3; $padString; $alignToLeft)
		
	: ($param=5)
		
		$padString:=$4
		
		Case of 
			: (Lowercase:C14($5)="LJ")
				$isOK:=PHP Execute:C1058(""; "str_pad"; $fmt; $strValue; $3; $padString; $alignToRight)
				
			: (Lowercase:C14($5)="RJ")
				$isOK:=PHP Execute:C1058(""; "str_pad"; $fmt; $strValue; $3; $padString; $alignToLeft)
				
			: (Lowercase:C14($5)="CE")
				$isOK:=PHP Execute:C1058(""; "str_pad"; $fmt; $strValue; $3; $padString; $alignToCenter)
				
			Else 
				$isOK:=PHP Execute:C1058(""; "str_pad"; $fmt; $strValue; $3; $padString; $alignToRight)
				
		End case 
		
End case 

If ($isOk)
	$0:=$fmt
Else 
	$0:=""
End if 


