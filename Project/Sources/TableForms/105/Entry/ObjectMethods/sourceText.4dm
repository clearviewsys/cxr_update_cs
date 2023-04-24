Case of 
		
	: (Form event code:C388=On Data Change:K2:15)
		
		If (Is new record:C668([DB_Keywords:105]))
			setKeywordPrefix(->[DB_Keywords:105]Keyword:3; arrkeywordsType{arrkeywordsType}; [DB_Keywords:105]sourceText:4)
			
			//C_TEXT($keywId)
			//$keywId:=Lowercase([Keywords]sourceText)
			//$keywId:=Replace string($keywId;" ";"_")
			//$keywId:="cvs_"+$keywId
			
			//[Keywords]keywordID:=$keywId
		End if 
		
End case 

