//%attributes = {"publishedWeb":true}
C_TEXT:C284(webSubject; webMessageBody)

checkInit
checkIfNullString(->webSubject; "Subject")
checkIfNullString(->webMessageBody; "Message Body")

If (checkErrorExist)
	//vErrorString:=checkGetErrorString 
	
	web_SendERRORPage($1)
Else 
	web_BCreate(->[MESSAGES:11])
	web_SendUserAreaPage
End if 