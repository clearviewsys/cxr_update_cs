
C_POINTER:C301($ptrTable; $ptrNil; $ptrListbox)
C_TEXT:C284($tFilePath; $tID)
C_LONGINT:C283($i; $iCount; $iCol; $iCurrCol; $iWidth)

$ptrTable:=Current default table:C363
$ptrListbox:=OBJECT Get pointer:C1124(Object named:K67:5; "LD_Listbox")

Case of 
	: (Form event code:C388=On Selection Change:K2:29) | (Form event code:C388=On Load:K2:1)
		If (Records in set:C195("$LinkedDocsListboxSet")>0)
			OBJECT SET ENABLED:C1123(*; "LD_Delete"; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(*; "LD_Delete"; False:C215)
		End if 
		
	: (Form event code:C388=On Double Clicked:K2:5)
		GOTO SELECTED RECORD:C245([LinkedDocs:4]; Selected record number:C246([LinkedDocs:4]))
		If (Is new record:C668($ptrTable->))
			openFormWindow(->[LinkedDocs:4]; "view")
		Else 
			handledoubleclickevent(->[LinkedDocs:4])
		End if 
		
		
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
		
		C_POINTER:C301($ptrField)
		$ptrField:=getPrimaryKeyFieldPtr($ptrTable)
		$tID:=$ptrField->
		
		If ($ptrTable=(->[Invoices:5]))  //<>TODO do we need to do something for other tables if NEW record?
			If ([Invoices:5]InvoiceID:1="")
				$tID:=vInvoiceNumber
			End if 
		End if 
		
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
					
					[LinkedDocs:4]RelatedTableNum:23:=Table:C252($ptrTable)
					[LinkedDocs:4]RelatedTableID:24:=$tID
					
					[LinkedDocs:4]creationDate:15:=Current date:C33
					[LinkedDocs:4]createdByUser:14:=getApplicationUser
					
					SAVE RECORD:C53([LinkedDocs:4])
				End if 
				
			End for 
			
			QUERY:C277([LinkedDocs:4]; [LinkedDocs:4]RelatedTableNum:23=Table:C252($ptrTable); *)
			QUERY:C277([LinkedDocs:4];  & ; [LinkedDocs:4]RelatedTableID:24=$tID)
		End if 
		
	: (Form event code:C388=On Expand:K2:41)
		ALERT:C41("expand")
		
	: (Form event code:C388=On Column Resize:K2:31)
		OBJECT GET COORDINATES:C663($ptrListbox->; $iLeft; $iTop; $iRight; $iBottom)
		$iWidth:=$iRight-$iLeft
		$iCol:=2  //default number of colums
		
		If ($iWidth>260)
			$iCol:=3
		End if 
		
		If ($iWidth>300)
			$iCol:=4
		End if 
		
		$iCurrCol:=LISTBOX Get number of columns:C831($ptrListbox->)
		
		Case of 
			: ($iCol=$iCurrCol)  //no change
				
			: ($iCol>$iCurrCol)  //add columes
				If ($iCurrCol=2)
					LISTBOX INSERT COLUMN:C829($ptrListbox->; 3; "Type"; [LinkedDocs:4]TypeOfDoc:5; "Type"; $ptrNil)
					LISTBOX SET COLUMN WIDTH:C833(*; "Type"; 30)
					OBJECT SET VERTICAL ALIGNMENT:C1187([LinkedDocs:4]TypeOfDoc:5; Align center:K42:3)
				End if 
				
				If ($iCurrCol=3)
					LISTBOX INSERT COLUMN:C829($ptrListbox->; 4; "Description"; [LinkedDocs:4]Description:9; "Description"; $ptrNil)
					LISTBOX SET COLUMN WIDTH:C833(*; "Description"; 150)
					OBJECT SET VERTICAL ALIGNMENT:C1187([LinkedDocs:4]Description:9; Align center:K42:3)
				End if 
				
				
			: ($iCol<$iCurrCol)  //rmove columes
				
				For ($i; 1; Abs:C99($iCol-$iCurrCol))
					LISTBOX DELETE COLUMN:C830($ptrListbox->; $iCurrCol-$i+1)
				End for 
				
		End case 
		
		If (False:C215)  //keeps calling on colume resize
			$iCurrCol:=LISTBOX Get number of columns:C831($ptrListbox->)
			
			LISTBOX SET COLUMN WIDTH:C833(*; "DocReference"; 150)
			
			If ($iCurrCol>=3)
				LISTBOX SET COLUMN WIDTH:C833(*; "Type"; 30)
			End if 
			
			If ($iCurrCol>=4)
				LISTBOX SET COLUMN WIDTH:C833(*; "Description"; 30)
			End if 
		End if 
		
		REDRAW:C174($ptrListbox->)
		
End case 