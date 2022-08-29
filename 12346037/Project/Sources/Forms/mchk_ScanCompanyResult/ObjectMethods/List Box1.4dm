C_LONGINT:C283($i)
C_TEXT:C284($path)
C_REAL:C285($detailProgress)
C_OBJECT:C1216($text)

Case of 
	: (Form event code:C388=On Load:K2:1)
		Form:C1466.selectedEntity:=Null:C1517
	: (Form event code:C388=On Selection Change:K2:29)
		If (Form:C1466.selectedEntity=Null:C1517)
			Form:C1466.selected:=Null:C1517
			Form:C1466.originalScriptNames:=New collection:C1472
			
			For ($i; 1; 8)
				OBJECT SET PLACEHOLDER:C1295(*; "txt_scanDetails"+String:C10($i); "Select a company to see details")
			End for 
		Else 
			
			$detailProgress:=Progress New
			Progress SET TITLE($detailProgress; "Loading details.")
			Progress SET WINDOW VISIBLE(True:C214)
			Progress SET MESSAGE($detailProgress; "Requesting from Member Check.")
			
			C_OBJECT:C1216($data)
			C_TEXT:C284($path)
			$path:=String:C10(Form:C1466.selectedEntity.resultId)
			$path:="/api/v1/corp-scans/single/results/"+$path
			$data:=mchk_httpRequestMemberCheck(HTTP GET method:K71:1; $path)
			
			If ($data.status=200)
				Form:C1466.selected:=$data.returned
				
				Progress SET MESSAGE($detailProgress; "Clean up.")
				Form:C1466.originalScriptNames:=New collection:C1472
				C_TEXT:C284($string)
				For each ($string; Form:C1466.selected.entity.originalScriptNames)
					$text:=New object:C1471
					$text.text:=$string
					Form:C1466.originalScriptNames.push($text)
				End for each 
			End if 
		End if 
		
		For ($i; 1; 8)
			OBJECT SET PLACEHOLDER:C1295(*; "txt_scanDetails"+String:C10($i); "No data")
		End for 
End case 