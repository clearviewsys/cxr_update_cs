//%attributes = {}
// sl_k20DisplayDetails($formEvent;$refId;$details)
// Author: Wai-Kin

var $formEvent : Integer
var $details : Collection
var $refId : Text
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
		var $detail : Object
		$detail:=$detail.find("slold_k20FindDetail"; Form:C1466.smartScan["Search Reference ID"])
		If ($detail#Null:C1517)
			C_LONGINT:C283($winRef)
			$winRef:=Open form window:C675("K20_SearchResult"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
			DIALOG:C40("K20_DetailResult"; $details[$refId])
			CLOSE WINDOW:C154($winRef)
		End if 
End case 

