//%attributes = {}
// ----------------------------------------------------

// User name (OS): Jonathan Le

// Date and time: 05/05/04, 17:03:26

// ----------------------------------------------------

// Method: Helper_GetPath

// Description

//  return the long path name to a file

// modified from 4D language manual

//

// Parameters

// ----------------------------------------------------

C_TEXT:C284($1; $0)
C_TEXT:C284($vsDirSymbol)
C_LONGINT:C283($viLen; $viPos; $viChar; $viDirSymbol)

If (Is Windows:C1573)
	$vsDirSymbol:="\\"
Else 
	$vsDirSymbol:=":"
End if 

$viDirSymbol:=Character code:C91($vsDirSymbol)
$viLen:=Length:C16($1)
$viPos:=0
For ($viChar; $viLen; 1; -1)
	If (Character code:C91($1[[$viChar]])=$viDirSymbol)
		$viPos:=$viChar
		$viChar:=0
	End if 
End for 
If ($viPos>0)
	$0:=Substring:C12($1; 1; $viPos)
Else 
	$0:=$1
End if 