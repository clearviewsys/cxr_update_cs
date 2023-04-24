//%attributes = {}
/** Returns the corresponding message for the result code of a check

#param $match
       result code
#return 
       result message
#edited @wai-kin
*/
#DECLARE($matchParam : Integer)->$message : Text
C_LONGINT:C283($match)

UTIL_Log("debug"; "in sl_getSanctionListResultMsg:  $matchParam: "+String:C10($matchParam))

Case of 
	: (Count parameters:C259=1)
		$match:=$matchParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

UTIL_Log("debug"; "3: in sl_getSanctionListResultMsg: $match: "+String:C10($match))

$message:=sl_setEmojiStatusIcon($match)
Case of 
		
	: ($match=-1)
		$message:=$message+"ERROR: Some sanction list/PEP CANNOT be used!"
		
		
		//$0:="ALERT: It Was not possible to check on the sanction list"
		
	: ($match=0)
		$message:=$message+"INFO: Name is not on any lists."
		//$0:="ALERT: Name is not on the Sanction List!"
		
	: ($match=2)
		$message:=$message+"ALERT: Name is ON one of the Sancion list/PEP!"
		//$0:="ALERT: Name IS ON the sanction List"
		
	: ($match=1)
		$message:=$message+"WARNING:Similar name is ON on the the Santion list/PEP"
		//$0:="ALERT: Similar Name is on the PEP sanction List"
		
End case 
UTIL_Log("debug"; "4. In sl_getSanctionListResultMsg $message: "+String:C10($match))
