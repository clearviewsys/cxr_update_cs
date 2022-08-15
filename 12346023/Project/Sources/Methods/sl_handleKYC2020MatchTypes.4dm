//%attributes = {}
// sl_k20FillMustMatch($formeEvent;$update)
var $event : Integer
$event:=Form event code:C388
var $update : Boolean
$update:=True:C214

Case of 
	: (Count parameters:C259=1)
		$event:=$1
	: (Count parameters:C259=2)
		$event:=$1
		$update:=$2
End case 

OBJECT SET ENABLED:C1123(*; "check_k20Name"; Form:C1466.KYC2020.fuzzy)
OBJECT SET ENABLED:C1123(*; "check_k20Address"; Form:C1466.KYC2020.fuzzy)
OBJECT SET ENABLED:C1123(*; "check_k20Id"; Form:C1466.KYC2020.fuzzy)

If ($update)
	If (Form:C1466.KYC2020.exact)
		[SanctionLists:113]Details:13.KYC2020.mustMatch:="true"
		
	Else 
		var $matches : Text
		If (Form:C1466.KYC2020.name=1)
			$matches:="1"
		End if 
		
		If (Form:C1466.KYC2020.address=1)
			If ($matches#"")
				$matches:=$matches+"|"
			End if 
			$matches:=$matches+"2"
		End if 
		
		If (Form:C1466.KYC2020.id=1)
			If ($matches#"")
				$matches:=$matches+"|"
			End if 
			$matches:=$matches+"3"
		End if 
		
		
		If ($matches#"")
			[SanctionLists:113]Details:13.KYC2020.mustMatch:=$matches
		Else 
			[SanctionLists:113]Details:13.KYC2020.mustMatch:="false"
		End if 
		
	End if 
End if 