//%attributes = {}
// ----------------------------------------------------

// User name (OS): Jonathan Le

// Date and time: 04/02/04, 09:27:34

// ----------------------------------------------------

// Method: BKP_XML_SetChoice

// Description

// 

//

// Parameters

// ----------------------------------------------------

C_POINTER:C301($1; $aChoices)
C_TEXT:C284($2; $tFind)

$aChoices:=$1
$tFind:="@"+$2+"@"

If (Find in array:C230($aChoices->; $tFind)#-1)
	$aChoices->{0}:=$aChoices->{Find in array:C230($aChoices->; $tFind)}
Else 
	$aChoices->{0}:=$aChoices->{1}
End if 
