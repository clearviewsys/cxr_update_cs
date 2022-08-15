//%attributes = {}
// ----------------------------------------------------

// User name (OS): Jonathan Le

// Date and time: 04/02/04, 09:28:01

// ----------------------------------------------------

// Method: BKP_XML_SetVariable

// Description

// 

//

// Parameters

// ----------------------------------------------------

C_POINTER:C301($1; $pVar)
C_TEXT:C284($2; $tVal)
C_LONGINT:C283($iVarType)

$pVar:=$1
$tVal:=$2
$iVarType:=Type:C295($pVar->)

// set a value to the pointer

Case of 
	: (($iVarType=Is text:K8:3) | ($iVarType=Is alpha field:K8:1) | ($iVarType=Is string var:K8:2))
		// if it's a text based var, just set it

		$pVar->:=$tVal
	: (($iVarType=Text array:K8:16))
		Helper_StringTokenizer($pVar; $tVal; Char:C90(13))
	Else 
		
		// if not, check for number or bool

		Case of 
			: ($tVal="True")
				$pVar->:=1
			: ($tVal="False")
				$pVar->:=0
			Else 
				$pVar->:=Num:C11($tVal)
		End case 
		
End case 