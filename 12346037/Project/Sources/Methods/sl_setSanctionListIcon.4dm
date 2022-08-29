//%attributes = {}
/** gets the picture for sanction screening result

#param $statusCodeParam
       the status code
#retun status as an picture
#edited @wai-kin
*/

#DECLARE($sanctionCheckResultParam : Integer)->$pic : Picture
C_PICTURE:C286($pic)
C_LONGINT:C283($sanctionCheckResult)


Case of 
		
	: (Count parameters:C259=0)
		$sanctionCheckResult:=[SanctionCheckLog:111]CheckResult:10
		
	: (Count parameters:C259=1)
		$sanctionCheckResult:=$sanctionCheckResultParam
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

//GET PICTURE FROM LIBRARY("AlertOk";$pic)
var $picName : Text
Case of 
		
	: ($sanctionCheckResult=-1)  // It was not possible to check (webservice down)
		$picName:="AlertFail.png"
		
	: ($sanctionCheckResult=0)
		$picName:="AlertOk.png"
		
	: ($sanctionCheckResult=2)  // Exact Match
		$picName:="AlertRed.png"
		
	: ($sanctionCheckResult=1)  // No Exact Match
		$picName:="AlertOrange.png"
		
End case 

var $pass : Boolean
$pass:=loadPictureResource($picName; ->$pic)

TRANSFORM PICTURE:C988($pic; Scale:K61:2; 0.4; 0.4)

// Modified by JA: Not necessary
// $0:=$pic
