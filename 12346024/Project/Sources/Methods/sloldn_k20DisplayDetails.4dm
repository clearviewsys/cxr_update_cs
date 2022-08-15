//%attributes = {}
// sln_k20DisplayDetails($formEvent;$refId;$details)
// Author: Wai-Kin

var $formEvent : Integer
var $details : Collection
var $refId : Text
var $detail : Object  // added by @milan to fix compiler error

$formEvent:=Form event code:C388
$details:=Form:C1466.kyc2020[0].details
$refId:=Form:C1466.selected["Search Reference ID"]

Case of 
	: (Count parameters:C259=1)
		$formEvent:=$1
	: (Count parameters:C259=2)
		$formEvent:=$1
		$refId:=$2
	: (Count parameters:C259=3)
		$formEvent:=$1
		$refId:=$2
		$details:=$3
End case 

Case of 
	: ($formEvent=On Clicked:K2:4)
		var $id : Text
		$id:=Form:C1466.smartScan["Search Reference ID"]
		$detail:=$details.find("slold_k20FindDetail"; $id)
		If ($detail#Null:C1517)
			$detail:=slold_k20requestSanctionDetails($id)
		End if 
End case 