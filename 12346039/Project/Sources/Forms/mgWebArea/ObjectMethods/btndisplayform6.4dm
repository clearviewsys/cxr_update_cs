C_TEXT:C284($finalPage; $mypage)

If (Form:C1466.transaction.transactionType="Send")
	
	Form:C1466.afterSubmitURL:=Form:C1466.session.endpoints.afterSendURL
	
	$mypage:=mgGetDocument("sendform.html")
	$finalPage:=Replace string:C233($mypage; "{getFormData}"; mgGetFormHTML(Form:C1466.transaction))
	$finalPage:=Replace string:C233($finalPage; "{URL}"; Form:C1466.session.endpoints.sendURL)
	
Else 
	
	Form:C1466.afterSubmitURL:=Form:C1466.session.endpoints.afterReceiveURL
	
	$mypage:=mgGetDocument("receiveform.html")
	$finalPage:=Replace string:C233($mypage; "{getFormData}"; mgGetFormHTML(Form:C1466.transaction))
	$finalPage:=Replace string:C233($finalPage; "{URL}"; Form:C1466.session.endpoints.receiveURL)
	
End if 

WA SET PAGE CONTENT:C1037(*; "mywa"; $finalPage; Form:C1466.session.endpoints.baseURL)
