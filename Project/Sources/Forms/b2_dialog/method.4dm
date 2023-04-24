
Case of 
		
		
	: (Form event code:C388=On Load:K2:1)
		
		
		OBJECT SET ENABLED:C1123(*; "btnDownloadFromCloud"; False:C215)
		OBJECT SET ENABLED:C1123(*; "btnUploadToCloud"; False:C215)
		OBJECT SET ENABLED:C1123(*; "btnShowFolder"; False:C215)
		
		
		b2_refreshLocalFileList
		
		Form:C1466.b2:=b2_getKeyValues
		
End case 
