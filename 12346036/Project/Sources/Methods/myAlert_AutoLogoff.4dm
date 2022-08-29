//%attributes = {"shared":true}
// myAlert(string;{alert message};<X>;<y>;<Z>)

C_TEXT:C284($1; $alertMessage; $2; $3; $4; $5; $tagX; $tagY; $tagZ)
C_OBJECT:C1216($oForm)
$oForm:=New object:C1471()


Case of 
	: (Count parameters:C259=0)
		$alertmessage:="The Name of this company is <Y>"
		$oForm.alertSubject:="http://www.clearviewsys.com"
		$tagX:="x"
		$tagY:="http://www.clearviewsys.com"
		$tagZ:="world"
	: (Count parameters:C259=1)
		$alertMessage:=$1
		$oForm.alertSubject:="Alert"
		
	: (Count parameters:C259=2)
		$alertMessage:=$1
		$oForm.alertSubject:=$2
		
	: (Count parameters:C259=3)
		$alertMessage:=$1
		$oForm.alertSubject:=$2
		$tagX:=$3
		
	: (Count parameters:C259=4)
		$alertMessage:=$1
		$oForm.alertSubject:=$2
		$tagX:=$3
		$tagY:=$4
		
	: (Count parameters:C259=5)
		$alertMessage:=$1
		$oForm.alertSubject:=$2
		$tagX:=$3
		$tagY:=$4
		$tagZ:=$5
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

replaceXYZTags(->$alertMessage; $tagX; $tagY; $tagZ)
$oForm.alertMessage:=$alertMessage

If ((Application type:C494#4D Server:K5:6) & ($oForm.alertMessage#""))
	C_LONGINT:C283($winRef)
	$winRef:=Open form window:C675("AlertDialog"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4)
	<>autoLogoffAlertId:=$winRef
	DIALOG:C40("AlertDialog"; $oForm)
	
	CLOSE WINDOW:C154($winRef)
End if 