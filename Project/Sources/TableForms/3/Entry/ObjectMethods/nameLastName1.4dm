Case of 
	: (Form event code:C388=On Data Change:K2:15)
		// getBuild
		C_POINTER:C301($self)
		C_TEXT:C284($tag)
		$self:=Self:C308
		pickTags($self; True:C214)
		If (Position:C15($self->; $tag)=0)
			$self->:=$tag+" "+$self->
		End if 
		
End case 

