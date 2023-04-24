If ((Form:C1466.credentials.username#"") & (Form:C1466.credentials.password#"") & (Form:C1466.credentials.agentID#""))
	
	Form:C1466.formName:="mgWebArea"
	Form:C1466.mywa:="mywa"
	
	If (Shift down:C543)
		Form:C1466.object.isDebug:="true"
	End if 
	
	OBJECT SET ENABLED:C1123(*; "btn_cancel"; False:C215)  // so that user can't accidentaly close the window
	
	mgStart
	
	OBJECT SET ENABLED:C1123(*; "btn_cancel"; True:C214)
	
Else 
	
	myAlert("All credential properties must be entered!")
	
End if 
