//handleListBoxObjectMethod(Self;Current form table)
//ALERT("here")

C_LONGINT:C283($col; $row)
C_TEXT:C284($localPath)

Case of 
	: (Form event code:C388=On Load:K2:1)
		relateManyLinkedDocs
		
		OBJECT SET VISIBLE:C603(*; "linkedDocPreview"; False:C215)
		OBJECT SET VISIBLE:C603(*; "linkedDocWebArea"; False:C215)
		
	: (Form event code:C388=On Double Clicked:K2:5)
		handledoubleclickevent(->[LinkedDocs:4])
		
		//openFormWindow(->[LinkedDocs]; "HybridViewPic_File")
		
		
	: ((Form event code:C388=On Clicked:K2:4))
		
		LISTBOX GET CELL POSITION:C971(Focus object:C278->; $col; $row)
		
		If ($row>0)
			LOAD RECORD:C52([LinkedDocs:4])
			
			Case of 
				: ([LinkedDocs:4]mimeType:27="image/@") | ([LinkedDocs:4]filePath:26="")
					OBJECT SET VISIBLE:C603(*; "linkedDocPreview"; True:C214)
					OBJECT SET VISIBLE:C603(*; "linkedDocWebArea"; False:C215)
					
				: ([LinkedDocs:4]filePath:26#"")
					$localPath:=DOC_retrieveDocumentPath([LinkedDocs:4]filePath:26)  //;$localPath;$doDelete)
					
					If ($localPath#"")
						If (Is macOS:C1572)
							$localPath:="file://"+Convert path system to POSIX:C1106($localPath)
						End if 
						WA OPEN URL:C1020(webArea; $localPath)
					End if 
					
					OBJECT SET VISIBLE:C603(*; "linkedDocPreview"; False:C215)
					OBJECT SET VISIBLE:C603(*; "linkedDocWebArea"; True:C214)
					
				Else 
					OBJECT SET VISIBLE:C603(*; "linkedDocPreview"; True:C214)
					OBJECT SET VISIBLE:C603(*; "linkedDocWebArea"; False:C215)
			End case 
			
		Else 
			OBJECT SET VISIBLE:C603(*; "linkedDocPreview"; False:C215)
			OBJECT SET VISIBLE:C603(*; "linkedDocWebArea"; False:C215)
		End if 
		
		
		
		
		
		
End case 