//%attributes = {}
// matchBooleanToTristateRule ($match; $boolean; $tristate) 

C_BOOLEAN:C305($match; $1; $0)
C_LONGINT:C283($tristate; $2)
C_LONGINT:C283($ruleTristate; $3)

$match:=$1
$tristate:=$2
$ruleTristate:=$3


If ($match & ($ruleTristate#0))  // check walkin status of customer against the rule
	//[Customers]AML_isSuspicious
	$match:=((($tristate=1) & ($ruleTristate=1)) | (($tristate=2) & ($ruleTristate=2)))
End if 

$0:=$match