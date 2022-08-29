//Author: Wai-Kin

//Case of
//: ((Form event code=On Load) | (Form event code=On Outside Call))
//Form.search:=New object
//Form.searchFields:=1
//Form.searchValues:=1
//Form.showAllMatches:=1
//If (Form.isEntity)
//Form.titleText:="Entity Matches for "
//Else
//Form.titleText:="Person Matches for "
//End if
//Form.titleText:=Form.titleText+"\""+Form.name+"\""
//End case

//C_TEXT($helpText)
//$helpText:="Search fields & values"
//C_BOOLEAN($searchFields; $searchValues)
//$searchFields:=Form.display.searchFields
//$searchValues:=Form.display.searchValues
//If ($searchFields)
//If (Not(Form.display.searchValues))
//$helpText:="Search field names"
//End if
//Else
//If ($searchValues)
//$helpText:="Search match values"
//End if
//End if
//OBJECT SET PLACEHOLDER(*; "SearchList"; $helpText)
sl_handleReviewFormEvent