C_LONGINT:C283($p)

Case of 
		
		
	: (Form event code:C388=On Load:K2:1)
		
		$p:=Find in array:C230(arrkeywordsType; [DB_Keywords:105]Type:2)
		If ($p>0)
			arrkeywordsType:=$p
		Else 
			arrkeywordsType:=1
		End if 
		[DB_Keywords:105]Type:2:=arrkeywordsType{arrkeywordsType}
		
		
	: (Form event code:C388=On Clicked:K2:4)
		[DB_Keywords:105]Type:2:=arrkeywordsType{arrkeywordsType}
		setKeywordPrefix(->[DB_Keywords:105]Keyword:3; arrkeywordsType{arrkeywordsType}; [DB_Keywords:105]sourceText:4)
		
End case 


