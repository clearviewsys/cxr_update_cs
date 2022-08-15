
C_TEXT:C284($formName)
$formName:=getKeyValue("KYC.ApplicationForm"; "Customer_AppForm")
If (Position:C15(<>CompanyName; "MoneyWay")>0)
	$formName:=$formName+"_MW"
End if 

printRecordUsingPrinter(->[Customers:3]; $formName)
