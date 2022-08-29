//%attributes = {}
// matchBooleanToTristateRule ($match; $boolean; $tristate) 

C_BOOLEAN:C305($match; $1; $0)
C_BOOLEAN:C305($booleanState; $2)
C_LONGINT:C283($ruleTristate; $3)

$match:=$1
$booleanState:=$2
$ruleTristate:=$3


If ($match & ($ruleTristate#0))  // check walkin status of customer against the rule
	//[Customers]AML_isSuspicious
	$match:=((($booleanState=True:C214) & ($ruleTristate=1)) | (($booleanState=False:C215) & ($ruleTristate=2)))
End if 

$0:=$match

