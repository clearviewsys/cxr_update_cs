//%attributes = {}
// getLocalizedKeyword (str) -> localized common keyword

// Modified on 2/8/2017 BY CVS Dev. Team

C_TEXT:C284($1; $keyword; $0)
C_TEXT:C284($language; $msg)

$keyword:=$1

// In case of error?
// $keyword:=Replace string($keyword;"cvs_";"")  // If the prefix is included by error
// $keyword:=Lowercase($keyword)

$keyword:="cvs_"+$keyword
$0:=$keyword

$msg:=Get localized string:C991($keyword)

If ($msg="")
	
	$language:=GetCurrentLocalization
	
	If ($language="en-US")
		
		Begin SQL
			SELECT DB_Keywords.sourceText FROM DB_Keywords WHERE DB_Keywords.keyword = :$keyword
			INTO <<$msg>>
		End SQL
		
	Else 
		
		Begin SQL
			SELECT DB_Translations.Translation FROM DB_Keywords, DB_Translations 
			WHERE DB_Keywords.keyword = :$keyword AND DB_Keywords.ID = DB_Translations.KeywordID AND DB_Translations.languageCode = :$language
			INTO <<$msg>>
		End SQL
		
	End if 
End if 


If ($msg#"")
	$0:=$msg
End if 