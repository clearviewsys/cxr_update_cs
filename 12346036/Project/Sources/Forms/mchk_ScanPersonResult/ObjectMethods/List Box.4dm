Case of 
	: (Form event code:C388=On Load:K2:1)
		Form:C1466.selectedPerson:=Null:C1517
	: (Form event code:C388=On Selection Change:K2:29)
		If (Form:C1466.selectedPerson=Null:C1517)
			Form:C1466.selected:=Null:C1517
			Form:C1466.selectedImage:=Null:C1517
			Form:C1466.originalScriptNames:=New collection:C1472
			
			C_LONGINT:C283($i)
			C_OBJECT:C1216($data)
			For ($i; 1; 41)
				OBJECT SET PLACEHOLDER:C1295(*; "txt_scanDetails"+String:C10($i); "Select a person to see details")
			End for 
		Else 
			C_REAL:C285($detailProgress)
			$detailProgress:=Progress New
			Progress SET TITLE($detailProgress; "Loading details.")
			Progress SET WINDOW VISIBLE(True:C214)
			Progress SET MESSAGE($detailProgress; "Requesting from Member Check.")
			
			C_TEXT:C284($path)
			$path:=String:C10(Form:C1466.selectedPerson.resultId)
			$path:="/api/v1/member-scans/single/results/"+$path
			$data:=mchk_httpRequestMemberCheck(HTTP GET method:K71:1; $path)
			
			If ($data.status=200)
				Form:C1466.selected:=$data.returned
				If (OB Is defined:C1231(Form:C1466.selected.person; "image"))
					Progress SET MESSAGE($detailProgress; "Requesting image.")
					C_PICTURE:C286($picture)
					C_TEXT:C284($path)
					$path:=Form:C1466.selected.person.image
					C_TEXT:C284($content)
					$content:=""
					C_PICTURE:C286($picture)
					C_LONGINT:C283($status)
					$status:=HTTP Request:C1158(HTTP GET method:K71:1; $path; $content; $picture)
					Form:C1466.selectedImage:=$picture
				Else 
					Form:C1466.selectedImage:=Null:C1517
				End if 
				
				Progress SET MESSAGE($detailProgress; "Clean up.")
				Form:C1466.originalScriptNames:=New collection:C1472
				C_TEXT:C284($string)
				For each ($string; Form:C1466.selected.person.originalScriptNames)
					C_OBJECT:C1216($text)
					$text:=New object:C1471
					$text.text:=$string
					Form:C1466.originalScriptNames.push($text)
				End for each 
				
				For ($i; 1; 41)
					OBJECT SET PLACEHOLDER:C1295(*; "txt_scanDetails"+String:C10($i); "No data")
				End for 
				
				Progress QUIT($detailProgress)
				Progress SET WINDOW VISIBLE(False:C215)
			End if 
		End if 
End case 