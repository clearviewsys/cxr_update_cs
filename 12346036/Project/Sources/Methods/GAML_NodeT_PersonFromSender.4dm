//%attributes = {}
// GAML_NodeT_PersonFromSender ($node)

C_TEXT:C284($1; $node)
C_TEXT:C284($element)

Case of 
	: (Count parameters:C259=1)
		$node:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_LONGINT:C283($pos)
C_TEXT:C284($element; $fn; $ln; $birthDate)

$pos:=Position:C15(" "; [eWires:13]SenderName:7)
$fn:=Substring:C12([eWires:13]SenderName:7; 1; $pos-1)
$ln:=Substring:C12([eWires:13]SenderName:7; $pos+1)

$fn:=FJ_Trim($fn)
$element:=GAML_CreateXMLNode($node; "first_name"; ->$fn)
$ln:=FJ_Trim($ln)
$element:=GAML_CreateXMLNode($node; "last_name"; ->$ln)

If ([eWires:13]senderDOB:101#Date:C102("00/00/00"))
	$birthDate:=FT_GetStringDate([eWires:13]senderDOB:101; "-")+"T"+FT_GetStringTime(Time:C179("00:00:00"); ":")
	GAML_CreateXMLNode($node; "birthdate"; ->$birthDate)
End if 


GAML_SetPhones($node; ->[eWires:13]senderPhone:97)
GAML_SetAddress($node; ->[eWires:13]senderAddress:96; ->[eWires:13]senderCity:98; ->[eWires:13]senderState:99; ->[eWires:13]senderPostalCode:100; ->[eWires:13]fromCountryCode:111)

$element:=GAML_CreateXMLNode($node; "email"; ->[eWires:13]senderEmail:102)
//$element:=GAML_CreateXMLNode ($node;"id_number";->[eWires]senderGovernmentID)

