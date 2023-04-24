//%attributes = {}
// gets URLs to MoneyGram services from external JSON file
C_OBJECT:C1216($0)
C_TEXT:C284($mypage)

$mypage:=mgGetDocument("endpoints.json")

If ($mypage#"")
	
	$0:=JSON Parse:C1218($mypage)
	
Else 
	
	$0:=New object:C1471
	
	$0.newSession:="https://tmg15.sb.com.ua/MG/CXR/IntegratedLogin.aspx"
	$0.sendURL:="https://tmg15.sb.com.ua/MG/CXR/IntegratedSend.aspx"
	$0.receiveURL:="https://tmg15.sb.com.ua/MG/CXR/IntegratedReceive.aspx"
	$0.afterSendURL:="https://tmg15.sb.com.ua/MG/Operator/QuickSend.aspx"
	$0.afterReceiveURL:="https://tmg15.sb.com.ua/MG/Operator/Receive.aspx"
	$0.afterFinishURL:="https://tmg15.sb.com.ua/MG/Operator/Default4D.aspx"  // URL displayed after successful transaction - after submitting Profix form
	$0.baseURL:="https://tmg15.sb.com.ua/"
	$0.loginURL:="https://tmg15.sb.com.ua/MG/Login.aspx"
	$0.soap:=New object:C1471
	$0.soap.root:="soap:Envelope"
	$0.soap.namespace:="http://schemas.xmlsoap.org/soap/envelope/"
	$0.soap.namespaceName1:="xmlns"
	$0.soap.namespace1:="http://sb.com.ua/webservices/"
	$0.soap.soapURL:="https://tsws.sb.com.ua/swws/swws.asmx"
	$0.afterLoginURL:="https://tmg15.sb.com.ua/MG/default.aspx"
	
	//{
	//"newSession": "https://tmg15.sb.com.ua/MG/CXR/IntegratedLogin.aspx"0
	//"sendURL": "https://tmg15.sb.com.ua/MG/CXR/IntegratedSend.aspx"0
	//"receiveURL": "https://tmg15.sb.com.ua/MG/CXR/IntegratedReceive.aspx"0
	//"afterSendURL": "https://tmg15.sb.com.ua/MG/Operator/QuickSend.aspx"0
	//"afterReceiveURL": "https://tmg15.sb.com.ua/MG/Operator/Receive.aspx"0
	//"afterFinishURL": "https://tmg15.sb.com.ua/MG/Operator/Default4D.aspx"0
	//"baseURL": "https://tmg15.sb.com.ua/"0
	//"loginURL": "https://tmg15.sb.com.ua/MG/Login.aspx"0
	//"afterLoginURL": "https://tmg15.sb.com.ua/MG/default.aspx"0
	//"soap": {
	//"root": "soapenv:Envelope"0
	//"namespace": "http://schemas.xmlsoap.org/soap/envelope/"0
	//"namespaceName1": "xmlns:web"0
	//"namespace1": "http://sb.com.ua/webservices/"0
	//"soapURL": "https://tsws.sb.com.ua/swws/swws.asmx"
	//}
	//}
	
	
End if 
