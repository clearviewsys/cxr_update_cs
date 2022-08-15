//%attributes = {}
/** sets the sanction list icon with help tip
Checks the name against all sanction Lists and set the result Icon
#param $matchParam 
       the status result
#param $iconPtrParam [in]
       the icon to set
#param $useEmojiParam
       use emoji instead of picture?
#edited @Wai-Kin
*/
#DECLARE($matchParam : Integer; $iconPtrParam : Pointer; $useEmojiParam : Boolean)

var $match : Integer
var $iconPtr : Pointer
var $useEmoji : Boolean
$useEmoji:=False:C215

Case of 
	: (Count parameters:C259=2)
		$match:=$matchParam
		$iconPtr:=$iconPtrParam
		
	: (Count parameters:C259=3)
		$match:=$matchParam
		$iconPtr:=$iconPtrParam
		$useEmoji:=$useEmojiParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($helpTip)
$helpTip:=""
If (Value type:C1509($iconPtr->)=Is picture:K8:10)
	clearPictureField($iconPtr)
End if 
OBJECT SET HELP TIP:C1181($iconPtr; $helpTip)

If ($useEmoji)
	// TOFIX: The method "sl_setSanctionListIcon" is assigning a text to a Picture Variable
	//$iconPtr->:=sl_setEmojiStatusIcon($match)
	$iconPtr->:=sl_setSanctionListIcon($match)
Else 
	// TOFIX: it seems Sometimes the IconPtr is pointing to a var that is not a picture 
	If (Value type:C1509($iconPtr->)=Is picture:K8:10)
		$iconPtr->:=sl_setSanctionListIcon($match)
	End if 
	
End if 

$helpTip:=sl_getSanctionListResultMsg($match)
OBJECT SET HELP TIP:C1181($iconPtr->; $helpTip)

