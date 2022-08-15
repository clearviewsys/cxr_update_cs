//%attributes = {}
// ----------------------------------------------------

// User name (OS): Jonathan Le

// Date and time: 04/02/04, 09:28:24

// ----------------------------------------------------

// Method: GEN_OpenFormWindow

// Description

// 

//

// Parameters

// ----------------------------------------------------

C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_LONGINT:C283($iWinRef)

$iWinRef:=Open form window:C675($1->; $2; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)

If (Count parameters:C259>2)
	SET WINDOW TITLE:C213($3; $iWinRef)
End if 

DIALOG:C40($1->; $2)
CLOSE WINDOW:C154($iWinRef)