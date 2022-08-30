C_LONGINT:C283($i)

Case of 
		
		
	: (Form event code:C388=On Clicked:K2:4)
		
		If ([DB_Keywords:105]sourceText:4#"")
			
			
			QUERY:C277([DB_Translations:110]; [DB_Translations:110]KeywordID:2=[DB_Keywords:105]KeywordID:1)
			FIRST RECORD:C50([DB_Translations:110])
			READ WRITE:C146([DB_Translations:110])
			
			Case of 
				: (Records in selection:C76([DB_Translations:110])>0)
					
					While (Not:C34(End selection:C36([DB_Translations:110])))
						
						If (Not:C34([DB_Translations:110]isConfirmed:5))
							[DB_Translations:110]Translation:4:=TranslateKeyword([DB_Keywords:105]sourceText:4; [DB_Translations:110]languageCode:3)
							SAVE RECORD:C53([DB_Translations:110])
						End if 
						NEXT RECORD:C51([DB_Translations:110])
					End while 
					
					
				: (Records in selection:C76([DB_Translations:110])=0)
					
					READ WRITE:C146([DB_Translations:110])
					XLIFF_SetLanguages(False:C215)
					
					For ($i; 1; Size of array:C274(arrTargetLangs))
						
						CREATE RECORD:C68([DB_Translations:110])
						
						[DB_Translations:110]KeywordID:2:=[DB_Keywords:105]KeywordID:1
						[DB_Translations:110]Comments:6:=""
						[DB_Translations:110]dateconfirmed:7:=!00-00-00!
						[DB_Translations:110]isConfirmed:5:=False:C215
						[DB_Translations:110]isFlagged:8:=False:C215
						[DB_Translations:110]languageCode:3:=arrTargetLangs{$i}
						[DB_Translations:110]Translation:4:=TranslateKeyword([DB_Keywords:105]sourceText:4; [DB_Translations:110]languageCode:3)
						
						SAVE RECORD:C53([DB_Translations:110])
						
					End for 
					
			End case 
			QUERY:C277([DB_Translations:110]; [DB_Translations:110]KeywordID:2=[DB_Keywords:105]KeywordID:1)
			
			
		End if 
		
		
End case 

