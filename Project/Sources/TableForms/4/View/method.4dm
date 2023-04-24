C_TEXT:C284($localPath)

handleViewForm
RELATE ONE:C42([LinkedDocs:4]CustomerID:1)


Case of 
	: (Form event code:C388=On Load:K2:1)
		
		If ([LinkedDocs:4]mimeType:27="image/@") | ([LinkedDocs:4]filePath:26="")
			
			OBJECT SET VISIBLE:C603(*; "linkedDocWebArea"; False:C215)
			
		Else 
			// load document in web area - PDF
			$localPath:=DOC_retrieveDocumentPath([LinkedDocs:4]filePath:26)  //;$localPath;$doDelete)
			If (Is macOS:C1572)
				$localPath:="file://"+Convert path system to POSIX:C1106($localPath)
			End if 
			
			WA OPEN URL:C1020(webArea; $localPath)
			OBJECT SET VISIBLE:C603(*; "linkedDocPreview"; False:C215)
			
		End if 
	Else 
		
End case 