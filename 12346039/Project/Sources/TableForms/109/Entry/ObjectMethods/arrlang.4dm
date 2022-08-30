
C_LONGINT:C283($p)


Case of 
		
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(lang)
		ARRAY TEXT:C222(arrLang; 0)
		
		
		OCR_GetLanguages(->arrLang)
		
		// Set English Default OCR Lang
		arrLang:=1
		lang:="eng"
		
		
	: (Form event code:C388=On Clicked:K2:4)
		
		$p:=Position:C15("="; arrLang{arrLang})
		lang:=Substring:C12(arrLang{arrLang}; $p+1)
		lang:=Replace string:C233(lang; " "; "")
		
End case 
