//%attributes = {}
// fills send/receive web form we use to apss data to Profix web app

C_TEXT:C284($mypage; $finalPage)

Case of 
		
	: (Form:C1466.transaction.transactionType="Send")
		
		Form:C1466.afterSubmitURL:=Form:C1466.session.endpoints.afterSendURL
		Form:C1466.valueElement:="sendData"  // HTML element ID in which Profix returns data to 4D after succesful sending transaction
		Form:C1466.errorSpanId:="ctl00_ContentPlaceHolder1_ErrorLabel"
		
		$mypage:=mgGetDocument("sendform.html")
		$finalPage:=Replace string:C233($mypage; "{getFormData}"; mgGetFormHTML(Form:C1466.transaction))
		$finalPage:=Replace string:C233($finalPage; "{URL}"; Form:C1466.session.endpoints.sendURL)
		
		
		
	: (Form:C1466.transaction.transactionType="Receive")
		
		Form:C1466.afterSubmitURL:=Form:C1466.session.endpoints.afterReceiveURL
		Form:C1466.valueElement:="receiveData"  // HTML element ID in which Profix returns data to 4D after succesful receiving transaction
		Form:C1466.errorSpanId:="ErrorLabel"
		
		$mypage:=mgGetDocument("receiveform.html")
		$finalPage:=Replace string:C233($mypage; "{getFormData}"; mgGetFormHTML(Form:C1466.transaction))
		$finalPage:=Replace string:C233($finalPage; "{URL}"; Form:C1466.session.endpoints.receiveURL)
		
		
End case 

WA SET PAGE CONTENT:C1037(*; Form:C1466.mywa; $finalPage; Form:C1466.session.endpoints.baseURL)
