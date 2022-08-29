//%attributes = {}
//C_TEXT(webLoginID)

//If (webisContextAlive (webContextID))

//QUERY SELECTION([Links];[Links]AuthorizedUser=webLoginID)  ` select self created links only

//ORDER BY([Links];[Links]FullName;>)

//

//  `webTitle:=Char(1)+makeHTMLTitle5 (0;"Full Name";"LinkID";"Home Phone";"Work Phone";"CellPhone")

//  `webBody:=makeHTMLBody5 (->[Links];->[Links]FullName;->[Links]LinkID;->[Links]HomePhone;->[Links]WorkPhone;->[Links]CellPhone;webContextID)

//webSendHTMLPage (->[Links];"List";"*")

//webSendListPage ("CID")

//Else 

//webSendContextExpiredPage 

//End if 

web_ListSelectedTable(->[Links:17]; ->[Links:17]FullName:4; True:C214)
