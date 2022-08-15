C_TEXT:C284($reportID)
C_TEXT:C284($msg)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		$msg:="This option will create a report to submit a correction batch file that will delete a previously accepted report."+CRLF+CRLF
		
		$msg:=$msg+"You should know the report number to delete (Normally the number starts with RXXXXX or IRXXXX."+CRLF+CRLF
		$msg:=$msg+"This number must be taken from the Acknowledgement accepted batch received from FINTRAC (Column C)."+CRLF+CRLF
		$msg:=$msg+"Do you want to proceed?"
		
		myConfirm("This option will create a report to submit a correction batch file that will delete a previously accepted report. \nYou should know the report number to delete (Normally the number starts with RXXXXX or IRXXXX.\\n This number must be taken from the Ackn"+"owledgement accepted batch received from FINTRAC (Column C). \n\\n Do you want to proceed?")
		
		If (ok=1)
			$reportID:=Request:C163("Please Enter the report Number to Delete"; "")
			
			If ($reportID#"")
				generateDeleteLCTRReport($reportID)
			Else 
				myAlert("The report Number is blank. Please try Again")
			End if 
			
		End if 
		
End case 
