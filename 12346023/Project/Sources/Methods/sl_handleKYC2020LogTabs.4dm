//%attributes = {}
/** Handles the tabs in SanctionListKYC2020 form

#param $eventCodeParam
       Form event code
#param $selfParam
       The tab widget 
#param $summaryParam
       KYC2020 result JSON
#formEvents
       On Clicked, On Load, On Bound Variable Change
*/
#DECLARE($eventCodeParam : Integer; $selfParam : Pointer; $summaryParam : Object)
// author: Wai-Kin

var $eventCode : Integer
var $self : Pointer
var $summary : Object
$eventCode:=Form event code:C388
$self:=Self:C308
$summary:=Form:C1466.kyc2020.summary

Case of 
	: (Count parameters:C259=0)
	: (Count parameters:C259=1)
		$eventCode:=$eventCodeParam
	: (Count parameters:C259=2)
		$eventCode:=$eventCodeParam
		$self:=$selfParam
	: (Count parameters:C259=3)
		$eventCode:=$eventCodeParam
		$self:=$selfParam
		$summary:=$summaryParam
End case 
Case of 
	: (($eventCode=On Clicked:K2:4) | ($eventCode=On Load:K2:1)\
		 | ($eventCode=On Bound Variable Change:K2:52))
		var $pageCheck; $toBeginning : Boolean
		var $page : Integer
		$pageCheck:=True:C214
		$toBeginning:=False:C215
		$page:=$self->
		While ($pageCheck)
			If ($page=1)
				If (Not:C34(OB Is defined:C1231($summary; "smart-scan-summary")))
					$page:=$page+1
				End if 
			End if 
			If ($page=2)
				If (Not:C34(OB Is defined:C1231($summary; "diq-summary")))
					$page:=$page+1
				End if 
			End if 
			If ($page=3)
				If (Not:C34(OB Is defined:C1231($summary; "statistics")))
					$page:=$page+1
				End if 
			End if 
			If ($page=4)
				If (Not:C34(OB Is defined:C1231($summary; "articles")))
					$page:=$page+1
				End if 
			End if 
			If ($page>4)
				$page:=1
				If ($toBeginning)
					$pageCheck:=False:C215
				End if 
				$toBeginning:=True:C214
			Else 
				$pageCheck:=False:C215
			End if 
		End while 
		$self->:=$page
		FORM GOTO PAGE:C247($self->; *)
End case 