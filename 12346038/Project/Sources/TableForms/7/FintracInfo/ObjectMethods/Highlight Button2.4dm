

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		C_TEXT:C284($amlRules; usingAMLRules)
		
		$amlRules:=getKeyValue("FT.UseAMLRules"; "1")
		
		If ($amlRules="1")
			setKeyValue("FT.UseAMLRules"; "0")
			usingAMLRules:="No"
		Else 
			setKeyValue("FT.UseAMLRules"; "1")
			usingAMLRules:="Yes"
		End if 
		
End case 
