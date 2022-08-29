If (Form event code:C388=On Load:K2:1)
	Form:C1466.searchString:=""
	Form:C1466.ListBox:=Form:C1466.initialList
End if 

If (Form event code:C388=On Timer:K2:25)
	C_OBJECT:C1216($eSel)
	SET TIMER:C645(0)
	// #ORDA
	If (Get edited text:C655#"")
		C_TEXT:C284($searchString)
		$searchString:="@"+Get edited text:C655+"@"
		//[List_RiskFactors]Code
		$eSel:=ds:C1482.List_RiskFactors.query("RiskFactor = :1 OR Code = :1"; $searchString)  // map the selection of the table to the entity selection
		Form:C1466.ListBox:=Form:C1466.initialList.and($eSel).orderBy("RiskFactor")  // get the intersection of the search with the original selection
		
	Else 
		Form:C1466.ListBox:=Form:C1466.initialList
	End if 
End if 