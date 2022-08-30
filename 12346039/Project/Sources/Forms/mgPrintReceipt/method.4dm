Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		WA SET PREFERENCE:C1041(*; "prnWA"; WA enable contextual menu:K62:6; True:C214)
		WA SET PREFERENCE:C1041(*; "prnWA"; WA enable Web inspector:K62:7; True:C214)
		//WA SET PREFERENCE(*; "prnWA"; _o_WA enable JavaScript; True)
		
		SET WINDOW TITLE:C213("Print your receipt ...")
		// WA OPEN URL(*;"prnWA";Form.receiptURL)
		If (Form:C1466.receiptHTML#"")
			WA SET PAGE CONTENT:C1037(*; "prnWA"; Form:C1466.receiptHTML; "http://127.0.0.1")
		End if 
		
		SET TEXT TO PASTEBOARD:C523(Form:C1466.receiptHTML)
		
		SET TIMER:C645(-1)
		
		
	: (Form event code:C388=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		C_TEXT:C284($js; $result)
		
		$js:="window.print();"
		
		$result:=WA Evaluate JavaScript:C1029(*; "prnWA"; $js)
		
		
End case 
