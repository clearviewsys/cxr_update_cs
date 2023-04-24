//handleListBoxObjectMethod(Self;Current form table)

C_LONGINT:C283($0)
C_LONGINT:C283($row; $col; $i)
C_TEXT:C284($command; $localPath)


Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET VISIBLE:C603(*; "linkedDocPreview"; False:C215)
		OBJECT SET VISIBLE:C603(*; "linkedDocWebArea"; False:C215)
		
	: ((Form event code:C388=On Clicked:K2:4))  // | (Form event code=On Load) | (Form event code=On Outside Call) | (Form event code=On Getting Focus))
		Form:C1466.currCustomerID:=[Customers:3]CustomerID:1
		
		LISTBOX GET CELL POSITION:C971(Focus object:C278->; $col; $row)
		
		If ($row>0)
			LOAD RECORD:C52([LinkedDocs:4])
			
			Case of 
				: ([LinkedDocs:4]mimeType:27="image/@")
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
		
	: (Form event code:C388=On Double Clicked:K2:5)
		modifyRecordLinkedDocs("Entry")
		
	: (Form event code:C388=On Drag Over:K2:13)
		// Accept On Drop event only if the pasteboard contains files, reject otherwise.
		If (Get file from pasteboard:C976(1)#"")  //at least one file dropped
			$0:=0  //accept drop
		Else   //no file in pasteboard
			$0:=-1  //reject drop
		End if 
		
	: (Form event code:C388=On Drop:K2:12)  //Requires Droppable action enabled from Property List
		ARRAY TEXT:C222($atPaths; 0)
		
		$i:=1
		Repeat 
			$localPath:=Get file from pasteboard:C976($i)
			If ($localPath#"")
				APPEND TO ARRAY:C911($atPaths; $localPath)
			End if 
			$i:=$i+1
		Until ($localPath="")
		
		
		Case of 
			: (Size of array:C274($atPaths)=1)
				REDUCE SELECTION:C351([LinkedDocs:4]; 0)
				createLinkedDoc(->[Customers:3]; $atPaths{1})
				PUSH RECORD:C176([Customers:3])
				modifyRecordLinkedDocs("Entry")
				POP RECORD:C177([Customers:3])
				
			: (Size of array:C274($atPaths)>1)
				
				REDUCE SELECTION:C351([LinkedDocs:4]; 0)
				
				For ($i; 1; Size of array:C274($atPaths))
					createLinkedDoc(->[Customers:3]; $atPaths{$i})
				End for 
				
			Else   //nothing
		End case 
		
		relateManyLinkedDocs
		
End case 
