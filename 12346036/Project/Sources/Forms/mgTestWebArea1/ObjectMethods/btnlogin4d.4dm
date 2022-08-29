// C_TEXT($finalPage;$mypage)

WA OPEN URL:C1020(*; "mywa"; Form:C1466.session.endpoints.newSession)
// WA OPEN URL(*;"mywa";"https://milan.adamov.rs/mg.html")
//WA OPEN URL(*;"mywa";"https://clearviewsys.4d.rs/mg.html")

//DELAY PROCESS(Current process;90)

//$mypage:=mgGetDocument ("loginform.html")

//$finalPage:=Replace string($mypage;"{agentId}";Form.credentials.agentID)
//$finalPage:=Replace string($finalPage;"{username}";Form.credentials.username)
//$finalPage:=Replace string($finalPage;"{password}";Form.credentials.password)
//$finalPage:=Replace string($finalPage;"{locale}";"en")
//$finalPage:=Replace string($finalPage;"{actionURL}";Form.session.endpoints.newSession)

//WA SET PAGE CONTENT(*;"mywa";$finalPage;Form.session.endpoints.baseURL)
