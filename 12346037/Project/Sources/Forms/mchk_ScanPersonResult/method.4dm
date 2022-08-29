If (Form:C1466.isCompany)
	FORM GOTO PAGE:C247(2)
End if 

If (OB Is defined:C1231(Form:C1466; "page"))
	OBJECT SET ENABLED:C1123(*; "but_firstPage"; Form:C1466.page#0)
	OBJECT SET ENABLED:C1123(*; "but_previousPage"; Form:C1466.page#0)
	OBJECT SET ENABLED:C1123(*; "but_nextPage"; Form:C1466.scanResult.matchedNumber/20<Form:C1466.page)
	OBJECT SET ENABLED:C1123(*; "but_lastPage"; Form:C1466.scanResult.matchedNumber/20<Form:C1466.page)
End if 
