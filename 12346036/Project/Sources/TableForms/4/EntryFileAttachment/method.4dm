C_TEXT:C284($path)

If (Form event code:C388=On Load:K2:1)
	If (Is new record:C668([LinkedDocs:4]))
	Else 
		//$path:=WAPI_uploadsFolder+[LinkedDocs]filePath
		////$systemPath:=Convert path POSIX to system($path) 
		
		//WA OPEN URL(webArea;$path)
		
	End if 
End if 

HandleEntryForm
