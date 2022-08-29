//%attributes = {}

Case of 
		
	: ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Outside Call:K2:11))
		
		handePreRecordKeywords
		XLIFF_SetLanguages(False:C215)
		
		RELATE MANY:C262([DB_Keywords:105]KeywordID:1)
		ORDER BY:C49([DB_Translations:110]; [DB_Translations:110]languageCode:3)
		
End case 

