//%attributes = {}


Case of 
	: (Form event code:C388=On Load:K2:1)
		XLIFF_SetLanguages(False:C215)
		QUERY:C277([DB_Translations:110]; [DB_Translations:110]languageCode:3=arrTargetLangs{arrTargetLangsDesc})
		LISTBOX SELECT ROW:C912(lboxEasy; 1)
		
		
	: (Form event code:C388=On Clicked:K2:4)
		
		QUERY:C277([DB_Translations:110]; [DB_Translations:110]languageCode:3=arrTargetLangs{arrTargetLangsDesc})
		LISTBOX SELECT ROW:C912(lboxEasy; 1)
		
End case 
