//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 04/11/18, 22:21:13
// ----------------------------------------------------
// Method: webGetChoiceList
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_POINTER:C301($1)  //option - pointer to array to fill
C_POINTER:C301($2)  //option value
C_POINTER:C301($3)  //option label




QUERY:C277([WireTemplates:42]; [WireTemplates:42]CustomerID:2=[Customers:3]CustomerID:1)

ORDER BY:C49([WireTemplates:42]; [WireTemplates:42]WireTemplateAlias:14; >)
SELECTION TO ARRAY:C260([WireTemplates:42]WireTemplateAlias:14; $1->)
SELECTION TO ARRAY:C260([WireTemplates:42]WireTemplateID:1; $2->)

INSERT IN ARRAY:C227($1->; 1)
$1->{1}:="-Select a Template-"
INSERT IN ARRAY:C227($2->; 1)
$2->{1}:=""