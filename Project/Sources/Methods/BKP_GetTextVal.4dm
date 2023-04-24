//%attributes = {}
// ----------------------------------------------------

// User name (OS): Jonathan Le

// Date and time: 04/02/04, 09:25:32

// ----------------------------------------------------

// Method: BKP_GetTextVal

// Description

// 

//

// Parameters

// ----------------------------------------------------

C_TEXT:C284($1; $0)
C_POINTER:C301($pVar)
C_LONGINT:C283($iVarType)

$pVar:=Get pointer:C304($1)
$iVarType:=Type:C295($pVar->)

Case of 
	: (($iVarType=Is text:K8:3) | ($iVarType=Is alpha field:K8:1) | ($iVarType=Is string var:K8:2))
		// if it's a text based var, just set it

		$0:=$pVar->
	: (BKP_isBool($1))
		If ($pVar->=1)
			$0:="True"
		Else 
			$0:="False"
		End if 
	Else 
		$0:=String:C10($pVar->)
End case 