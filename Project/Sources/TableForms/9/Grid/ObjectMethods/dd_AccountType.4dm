//handleDropDownMenu(->[Accounts]AccountType; "Account Type"; "filterAccountType")

var $self : Pointer
var $attribute : Text
var $list : Collection

$self:=Self:C308
$attribute:="filterAccountType"
$list:=New collection:C1472(""; Get localized string:C991("cvs_assets"))


If (Form event code:C388=On Load:K2:1)
	LIST TO ARRAY:C288("AccountTypes"; $self->)
End if 

If (Form event code:C388=On Clicked:K2:4)
	If ($Self->>1)  // if the till was selected
		Form:C1466[$attribute]:=$Self->{$Self->}
	Else 
		Form:C1466[$attribute]:=""
	End if 
End if 