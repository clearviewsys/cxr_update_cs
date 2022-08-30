
C_LONGINT:C283($i; $iCount)
C_TEXT:C284($tFilePath)


Case of 
	: (Form event code:C388=On Load:K2:1)
		If (Is new record:C668([Invoices:5]))
			REDUCE SELECTION:C351([LinkedDocs:4]; 0)
		Else 
			QUERY:C277([LinkedDocs:4]; [LinkedDocs:4]RelatedTableNum:23=Table:C252(->[Invoices:5]); *)
			QUERY:C277([LinkedDocs:4];  & ; [LinkedDocs:4]RelatedTableID:24=[Invoices:5]InvoiceID:1)
		End if 
		
		OBJECT SET ENABLED:C1123(*; "LD_Delete"; False:C215)
		
	: (Form event code:C388=On Selection Change:K2:29)
		If (Records in set:C195("$LinkedDocsListboxSet")>0)
			OBJECT SET ENABLED:C1123(*; "LD_Delete"; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(*; "LD_Delete"; False:C215)
		End if 
		
	: (Form event code:C388=On Double Clicked:K2:5)
		GOTO SELECTED RECORD:C245([LinkedDocs:4]; Selected record number:C246([LinkedDocs:4]))
		openFormWindow(->[LinkedDocs:4]; "view")
		//handledoubleclickevent (->[LinkedDocs])
		
	: (Form event code:C388=On Drag Over:K2:13)
		
		C_LONGINT:C283($0)
		
		$iCount:=0
		$i:=1
		Repeat 
			$tFilePath:=Get file from pasteboard:C976($i)  //get the file(s) being dropped
			If (Test path name:C476($tFilePath)=Is a document:K24:1)
				If (Is picture file:C1113($tFilePath))
					$iCount:=$iCount+1
				End if 
			End if 
			$i:=$i+1
		Until ($tFilePath="")
		
		If ($iCount>0)
			$0:=0
		Else 
			$0:=-1
		End if 
		
	: (Form event code:C388=On Drop:K2:12)
		
		ARRAY TEXT:C222($atFilePaths; 0)
		
		$i:=1
		Repeat 
			$tFilePath:=Get file from pasteboard:C976($i)  //get the file being dropped
			If (Test path name:C476($tFilePath)=Is a document:K24:1)
				If (Is picture file:C1113($tFilePath))
					APPEND TO ARRAY:C911($atFilePaths; $tFilePath)
				End if 
			End if 
			$i:=$i+1
		Until ($tFilePath="")
		
		$iCount:=Size of array:C274($atFilePaths)
		
		If ($iCount>0)
			
			For ($i; 1; $iCount)
				C_TEXT:C284($branchID)
				C_TIME:C306($time)
				C_PICTURE:C286($picture)
				
				READ PICTURE FILE:C678($atFilePaths{$i}; $picture)
				
				If (OK=1)
					CREATE RECORD:C68([LinkedDocs:4])
					[LinkedDocs:4]LinkedDocID:12:=makeLinkedDocID
					[LinkedDocs:4]UUID:19:=Generate UUID:C1066
					[LinkedDocs:4]CustomerID:1:=[Invoices:5]CustomerID:2
					
					[LinkedDocs:4]ScannedImage:2:=$picture
					[LinkedDocs:4]ScanDate:3:=Current date:C33
					
					[LinkedDocs:4]PictureIDTemplateID:20:=""
					[LinkedDocs:4]IssueDate:21:=!00-00-00!
					[LinkedDocs:4]IssuingAuthority:22:=""
					[LinkedDocs:4]IssueCountryCode:18:=[Customers:3]CountryCode:113
					[LinkedDocs:4]ExpiryDate:4:=!00-00-00!
					[LinkedDocs:4]TypeOfDoc:5:="N/A"
					[LinkedDocs:4]DocReference:6:=getFileName($atFilePaths{$i})
					[LinkedDocs:4]IssueCity:7:=""
					[LinkedDocs:4]IssueCountry:8:=getCountryNameByCode([LinkedDocs:4]IssueCountryCode:18)
					[LinkedDocs:4]Description:9:=""
					[LinkedDocs:4]isFlagged:13:=False:C215
					
					[LinkedDocs:4]RelatedTableNum:23:=Table:C252(->[Invoices:5])
					[LinkedDocs:4]RelatedTableID:24:=vInvoiceNumber
					
					[LinkedDocs:4]creationDate:15:=Current date:C33
					[LinkedDocs:4]createdByUser:14:=getApplicationUser
					
					SAVE RECORD:C53([LinkedDocs:4])
				End if 
				
			End for 
			
			QUERY:C277([LinkedDocs:4]; [LinkedDocs:4]RelatedTableNum:23=Table:C252(->[Invoices:5]); *)
			QUERY:C277([LinkedDocs:4];  & ; [LinkedDocs:4]RelatedTableID:24=[Invoices:5]InvoiceID:1)
		End if 
		
	Else 
		
End case 